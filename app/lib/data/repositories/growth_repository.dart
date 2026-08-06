import 'package:drift/drift.dart';

import '../../core/utils/id_generator.dart';
import '../local/database/app_database.dart';

/// Reads and writes growth (height/weight) entries for a profile.
class GrowthRepository {
  GrowthRepository(this._db, [this._ids = const IdGenerator()]);

  final AppDatabase _db;
  final IdGenerator _ids;

  Stream<List<GrowthEntryRow>> watchForProfile(String profileId) {
    return (_db.select(_db.growthEntries)
          ..where((t) => t.profileId.equals(profileId))
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.measuredAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .watch();
  }

  /// Latest entry that has a weight, used for the mg/kg calculation.
  Future<GrowthEntryRow?> latestWithWeight(String profileId) {
    return (_db.select(_db.growthEntries)
          ..where((t) => t.profileId.equals(profileId) & t.weightKg.isNotNull())
          ..orderBy([
            (t) => OrderingTerm(
                  expression: t.measuredAt,
                  mode: OrderingMode.desc,
                ),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<String> add({
    required String profileId,
    required DateTime measuredAt,
    double? heightCm,
    double? weightKg,
    String? notes,
    String source = 'manual',
  }) async {
    final id = _ids.next();
    await _db.into(_db.growthEntries).insert(
          GrowthEntriesCompanion.insert(
            id: id,
            profileId: profileId,
            measuredAt: measuredAt,
            heightCm: Value(heightCm),
            weightKg: Value(weightKg),
            notes: Value(notes),
            source: Value(source),
          ),
        );
    return id;
  }

  Future<void> delete(String id) {
    return (_db.delete(_db.growthEntries)..where((t) => t.id.equals(id))).go();
  }

  /// Re-inserts a previously deleted row (used for undo).
  Future<void> restore(GrowthEntryRow row) {
    return _db.into(_db.growthEntries).insert(row.toCompanion(false));
  }
}
