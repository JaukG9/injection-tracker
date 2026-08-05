import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/data/local/database/app_database.dart';
import 'package:injection_tracker/data/repositories/profile_repository.dart';
import 'package:injection_tracker/data/services/backup_service.dart';
import 'package:injection_tracker/domain/models/enums.dart';

/// A backup exactly in the shape the original HTML app's `exportAllData` writes.
const _v1Json = '''
{
  "app": "Injection Tracker Backup",
  "version": 1,
  "exportedAt": "2026-07-01T12:00:00.000Z",
  "childName": "Sameer",
  "growthUnit": "imperial",
  "currentDose": { "value": "0.6", "unit": "mg" },
  "injectionHistory": [
    { "id": "a1", "date": "2026-06-20", "site": "leftThigh", "notes": "ok", "doseValue": "0.6", "doseUnit": "mg" },
    { "id": "a2", "date": "2026-06-22", "site": "rightButtock", "notes": "", "doseValue": "0.6", "doseUnit": "mg" },
    { "id": "a3", "date": "2026-06-24", "site": "unknownSite", "notes": "bad site", "doseValue": "", "doseUnit": "" }
  ],
  "growthHistory": [
    { "id": "g1", "date": "2026-01-01", "heightCm": 130.0, "weightKg": 28.3, "notes": "clinic" },
    { "id": "g2", "date": "2026-07-01", "heightCm": 133.0, "weightKg": 29.1, "notes": "" }
  ]
}
''';

void main() {
  late AppDatabase db;
  late BackupService service;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    service = BackupService(db, ProfileRepository(db));
  });
  tearDown(() => db.close());

  test('imports a v1 backup into a new profile, mapping sites by key',
      () async {
    final json = jsonDecode(_v1Json) as Map<String, dynamic>;
    final result = await service.importV1(json);

    expect(result.profileName, 'Sameer');
    // The third injection references an unknown site and is skipped.
    expect(result.injections, 2);
    expect(result.growth, 2);

    // Profile prefs came across.
    final profile = await db.select(db.profiles).getSingle();
    expect(profile.unitSystem, UnitSystem.imperial.name);

    // Initial dose seeded from currentDose.
    final doses = await db.select(db.doseChanges).get();
    expect(doses.single.value, 0.6);

    // Injections resolved to real, profile-scoped sites.
    final injections = await db.select(db.injections).get();
    expect(injections, hasLength(2));
    expect(injections.every((i) => i.profileId == result.profileId), isTrue);

    // Growth heights preserved (already canonical cm).
    final growth = await db.select(db.growthEntries).get();
    expect(growth.map((g) => g.heightCm), containsAll([130.0, 133.0]));
  });

  test('round-trips: v2 export contains the imported data', () async {
    final result =
        await service.importV1(jsonDecode(_v1Json) as Map<String, dynamic>);
    final export = await service.exportProfile(result.profileId);

    expect(export['version'], 2);
    expect((export['injectionHistory'] as List), hasLength(2));
    expect((export['growthHistory'] as List), hasLength(2));
    expect((export['profile'] as Map)['name'], 'Sameer');
  });

  test('rejects a non-v1 file', () async {
    expect(
      () => service.importV1({'version': 9}),
      throwsA(isA<BackupException>()),
    );
  });

  test('v2 export/import round-trips into a new profile', () async {
    // Seed a profile via a v1 import, then export it as v2 and re-import.
    final first =
        await service.importV1(jsonDecode(_v1Json) as Map<String, dynamic>);
    final exported = await service.exportProfile(first.profileId);

    final restored = await service.importV2(exported);
    expect(restored.profileId, isNot(first.profileId));
    expect(restored.profileName, 'Sameer');
    expect(restored.injections, 2);
    expect(restored.growth, 2);

    // Two separate profiles now exist, each with its own isolated data.
    final profiles = await db.select(db.profiles).get();
    expect(profiles, hasLength(2));
    final restoredInjections = await (db.select(db.injections)
          ..where((t) => t.profileId.equals(restored.profileId)))
        .get();
    expect(restoredInjections, hasLength(2));

    // Dose timeline carried over (initial dose from the v1 import).
    final restoredDoses = await (db.select(db.doseChanges)
          ..where((t) => t.profileId.equals(restored.profileId)))
        .get();
    expect(restoredDoses, isNotEmpty);
  });

  test('rejects a non-v2 file for importV2', () async {
    expect(
      () => service.importV2({'version': 1}),
      throwsA(isA<BackupException>()),
    );
  });
}
