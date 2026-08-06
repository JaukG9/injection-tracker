import 'package:drift/drift.dart';

import '../../core/utils/id_generator.dart';
import '../../domain/models/enums.dart';
import '../local/database/app_database.dart';

/// Reads and writes injection log entries for a profile.
class InjectionRepository {
  InjectionRepository(this._db, [this._ids = const IdGenerator()]);

  final AppDatabase _db;
  final IdGenerator _ids;

  Stream<List<InjectionRow>> watchForProfile(String profileId) {
    return (_db.select(_db.injections)
          ..where((t) => t.profileId.equals(profileId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.injectedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  Future<String> add({
    required String profileId,
    required String siteId,
    String? medicationId,
    required DateTime injectedAt,
    double? doseValue,
    DoseUnit? doseUnit,
    String? notes,
    bool skipped = false,
    String? skippedReason,
  }) async {
    final id = _ids.next();
    await _db.into(_db.injections).insert(
          InjectionsCompanion.insert(
            id: id,
            profileId: profileId,
            siteId: siteId,
            medicationId: Value(medicationId),
            injectedAt: injectedAt,
            doseValue: Value(doseValue),
            doseUnit: Value(doseUnit?.name),
            notes: Value(notes),
            skipped: Value(skipped),
            skippedReason: Value(skippedReason),
            createdAt: DateTime.now(),
          ),
        );
    return id;
  }

  Future<void> delete(String id) {
    return (_db.delete(_db.injections)..where((t) => t.id.equals(id))).go();
  }

  /// Re-inserts a previously deleted row (used for undo).
  Future<void> restore(InjectionRow row) {
    return _db.into(_db.injections).insert(row.toCompanion(false));
  }
}
