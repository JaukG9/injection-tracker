import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'seed_sites.dart';
import 'tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Profiles,
    Medications,
    DoseChanges,
    InjectionSites,
    Injections,
    GrowthEntries,
    AppMetas,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  /// In-memory database for tests.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // Medication route + preset link.
            await m.addColumn(medications, medications.route);
            await m.addColumn(medications, medications.presetId);
            // Bring every existing profile's sites up to the new canonical set
            // (adds upper-arm + lower-abdomen sites, refreshes geometry).
            await customStatement('PRAGMA foreign_keys = OFF');
            final profiles = await select(this.profiles).get();
            for (final p in profiles) {
              await _reconcileSites(p.id);
            }
            await customStatement('PRAGMA foreign_keys = ON');
          }
        },
        beforeOpen: (details) async {
          // Enforce foreign keys so cascade deletes actually fire.
          await customStatement('PRAGMA foreign_keys = ON');
          // Always ensure the single settings row exists. Doing this on every
          // open (not just on creation) means the settings stream can never
          // throw on a database that predates this row.
          await into(appMetas).insert(
            AppMetasCompanion.insert(id: const Value('app')),
            mode: InsertMode.insertOrIgnore,
          );
        },
      );

  /// Upserts the canonical site set for one profile (used by the v2 migration).
  Future<void> _reconcileSites(String profileId) async {
    final existing = await (select(injectionSites)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final keys = {for (final s in existing) s.siteKey};
    for (final s in kSeedSites) {
      if (keys.contains(s.key)) {
        await (update(injectionSites)
              ..where((t) =>
                  t.profileId.equals(profileId) & t.siteKey.equals(s.key)))
            .write(InjectionSitesCompanion(
          name: Value(s.name),
          region: Value(s.region.name),
          bodyView: Value(s.view.name),
          cx: Value(s.cx),
          cy: Value(s.cy),
          rx: Value(s.rx),
          ry: Value(s.ry),
          sortOrder: Value(s.sortOrder),
        ));
      } else {
        await into(injectionSites).insert(
          InjectionSitesCompanion.insert(
            id: '${profileId}_${s.key}',
            profileId: profileId,
            siteKey: s.key,
            name: s.name,
            region: s.region.name,
            bodyView: s.view.name,
            cx: s.cx,
            cy: s.cy,
            rx: s.rx,
            ry: s.ry,
            sortOrder: Value(s.sortOrder),
          ),
        );
      }
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'injection_tracker.sqlite'));

    // Point sqlite's temp storage at a writable app cache dir.
    final cacheDir = await getTemporaryDirectory();
    sqlite3.tempDirectory = cacheDir.path;

    return NativeDatabase.createInBackground(file);
  });
}
