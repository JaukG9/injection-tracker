import 'package:drift/drift.dart';

import '../local/database/app_database.dart';

/// Reads injection sites for a profile.
class SiteRepository {
  SiteRepository(this._db);

  final AppDatabase _db;

  Stream<List<InjectionSiteRow>> watchForProfile(String profileId) {
    return (_db.select(_db.injectionSites)
          ..where((t) => t.profileId.equals(profileId))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .watch();
  }

  Future<List<InjectionSiteRow>> getForProfile(String profileId) {
    return (_db.select(_db.injectionSites)
          ..where((t) => t.profileId.equals(profileId))
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .get();
  }

  Future<void> setEnabled(String siteId, bool enabled) {
    return (_db.update(_db.injectionSites)..where((t) => t.id.equals(siteId)))
        .write(InjectionSitesCompanion(isEnabled: Value(enabled)));
  }

  /// Enables exactly the sites whose key is in [enabledKeys] for a profile,
  /// disabling the rest. Guards against disabling everything.
  Future<void> setEnabledByKeys(
      String profileId, Set<String> enabledKeys) async {
    if (enabledKeys.isEmpty) return;
    await _db.transaction(() async {
      final sites = await (_db.select(_db.injectionSites)
            ..where((t) => t.profileId.equals(profileId)))
          .get();
      for (final s in sites) {
        final shouldEnable = enabledKeys.contains(s.siteKey);
        if (s.isEnabled != shouldEnable) {
          await (_db.update(_db.injectionSites)
                ..where((t) => t.id.equals(s.id)))
              .write(InjectionSitesCompanion(isEnabled: Value(shouldEnable)));
        }
      }
    });
  }
}
