import 'package:drift/drift.dart';

import '../../core/utils/id_generator.dart';
import '../../domain/models/enums.dart';
import '../local/database/app_database.dart';

/// Reads medications and the current dose for a profile.
class MedicationRepository {
  MedicationRepository(this._db, [this._ids = const IdGenerator()]);

  final AppDatabase _db;
  final IdGenerator _ids;

  Stream<MedicationRow?> watchActive(String profileId) {
    return (_db.select(_db.medications)
          ..where((t) => t.profileId.equals(profileId) & t.isActive.equals(true))
          ..limit(1))
        .watchSingleOrNull();
  }

  /// The dose in effect on or before [asOf] (defaults to now). Ties on the same
  /// second are broken by insertion order (rowid) so the latest entry wins.
  Future<DoseChangeRow?> currentDose(String profileId, {DateTime? asOf}) {
    final when = asOf ?? DateTime.now();
    return (_db.select(_db.doseChanges)
          ..where((t) =>
              t.profileId.equals(profileId) &
              t.effectiveFrom.isSmallerOrEqualValue(when))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.effectiveFrom,
                  mode: OrderingMode.desc,
                ),
            (t) => OrderingTerm(
                  expression: const CustomExpression<int>('rowid'),
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Updates a medication's editable fields (name, preset, unit, route,
  /// schedule). Dose amount is managed separately via [changeDose].
  Future<void> updateMedication(
    String medicationId, {
    required String name,
    required String? presetId,
    required DoseUnit defaultUnit,
    required InjectionRoute route,
    required ScheduleType scheduleType,
    required String scheduleConfigJson,
  }) {
    return (_db.update(_db.medications)..where((t) => t.id.equals(medicationId)))
        .write(MedicationsCompanion(
      name: Value(name),
      presetId: Value(presetId),
      defaultDoseUnit: Value(defaultUnit.name),
      route: Value(route.name),
      scheduleType: Value(scheduleType.name),
      scheduleConfig: Value(scheduleConfigJson),
    ));
  }

  /// Sets (or clears with null) the daily reminder time "HH:mm".
  Future<void> setReminderTime(String medicationId, String? hhmm) {
    return (_db.update(_db.medications)..where((t) => t.id.equals(medicationId)))
        .write(MedicationsCompanion(reminderTime: Value(hhmm)));
  }

  Stream<List<DoseChangeRow>> watchDoseChanges(String profileId) {
    return (_db.select(_db.doseChanges)
          ..where((t) => t.profileId.equals(profileId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.effectiveFrom,
                  mode: OrderingMode.desc,
                ),
            (t) => OrderingTerm(
                  expression: const CustomExpression<int>('rowid'),
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  /// Records a dose change (for the timeline) and updates the medication's
  /// current default so the dashboard and new injections reflect it.
  Future<void> changeDose({
    required String profileId,
    required String medicationId,
    required double value,
    required DoseUnit unit,
    DateTime? effectiveFrom,
    String? reason,
  }) async {
    await _db.transaction(() async {
      await _db.into(_db.doseChanges).insert(
            DoseChangesCompanion.insert(
              id: _ids.next(),
              profileId: profileId,
              medicationId: medicationId,
              value: value,
              unit: unit.name,
              effectiveFrom: effectiveFrom ?? DateTime.now(),
              reason: Value(reason),
            ),
          );
      await (_db.update(_db.medications)
            ..where((t) => t.id.equals(medicationId)))
          .write(
        MedicationsCompanion(
          defaultDoseValue: Value(value),
          defaultDoseUnit: Value(unit.name),
        ),
      );
    });
  }
}
