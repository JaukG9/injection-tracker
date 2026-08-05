import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/data/local/database/app_database.dart';
import 'package:injection_tracker/data/repositories/growth_repository.dart';
import 'package:injection_tracker/data/repositories/injection_repository.dart';
import 'package:injection_tracker/data/repositories/profile_repository.dart';
import 'package:injection_tracker/data/repositories/site_repository.dart';
import 'package:injection_tracker/domain/models/enums.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository profiles;
  late SiteRepository sites;
  late InjectionRepository injections;
  late GrowthRepository growth;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    profiles = ProfileRepository(db);
    sites = SiteRepository(db);
    injections = InjectionRepository(db);
    growth = GrowthRepository(db);
  });

  tearDown(() => db.close());

  test('createFromDraft seeds the canonical sites, a medication and a dose',
      () async {
    final id = await profiles.createFromDraft(
      ProfileDraft(
        name: 'Emma',
        medicationName: 'Growth hormone',
        doseValue: 0.6,
      ),
    );

    final seeded = await sites.getForProfile(id);
    expect(seeded, hasLength(10));
    expect(seeded.map((s) => s.siteKey), contains('leftThigh'));
    expect(seeded.map((s) => s.siteKey), contains('leftArm'));
    expect(seeded.map((s) => s.siteKey), contains('lowerLeftAbdomen'));

    final meds = await db.select(db.medications).get();
    expect(meds, hasLength(1));
    expect(meds.single.profileId, id);

    final doses = await db.select(db.doseChanges).get();
    expect(doses, hasLength(1));
    expect(doses.single.value, 0.6);
  });

  test('injection and growth data is isolated per profile', () async {
    final emma = await profiles.createFromDraft(
      ProfileDraft(name: 'Emma', medicationName: 'GH'),
    );
    final liam = await profiles.createFromDraft(
      ProfileDraft(name: 'Liam', medicationName: 'GH'),
    );

    final emmaSite = (await sites.getForProfile(emma)).first;
    final liamSite = (await sites.getForProfile(liam)).first;

    await injections.add(
      profileId: emma,
      siteId: emmaSite.id,
      injectedAt: DateTime(2026, 7, 20),
      doseValue: 0.6,
      doseUnit: DoseUnit.mg,
    );
    await injections.add(
      profileId: emma,
      siteId: emmaSite.id,
      injectedAt: DateTime(2026, 7, 22),
    );
    await injections.add(
      profileId: liam,
      siteId: liamSite.id,
      injectedAt: DateTime(2026, 7, 21),
    );

    await growth.add(
        profileId: emma, measuredAt: DateTime(2026, 7, 1), heightCm: 130);
    await growth.add(
        profileId: liam, measuredAt: DateTime(2026, 7, 1), heightCm: 120);

    final emmaInj = await injections.watchForProfile(emma).first;
    final liamInj = await injections.watchForProfile(liam).first;
    expect(emmaInj, hasLength(2));
    expect(liamInj, hasLength(1));
    expect(emmaInj.every((i) => i.profileId == emma), isTrue);

    final emmaGrowth = await growth.watchForProfile(emma).first;
    expect(emmaGrowth.single.heightCm, 130);
  });

  test('archiving a profile hides it from the active list', () async {
    final id = await profiles.createFromDraft(
      ProfileDraft(name: 'Temp', medicationName: 'GH'),
    );
    expect(await profiles.watchAll().first, hasLength(1));
    await profiles.archive(id);
    expect(await profiles.watchAll().first, isEmpty);
  });

  test('deleting a profile cascades to its child rows', () async {
    final id = await profiles.createFromDraft(
      ProfileDraft(name: 'Gone', medicationName: 'GH', doseValue: 1),
    );
    final site = (await sites.getForProfile(id)).first;
    await injections.add(
        profileId: id, siteId: site.id, injectedAt: DateTime(2026, 7, 1));

    await (db.delete(db.profiles)..where((t) => t.id.equals(id))).go();

    expect(await db.select(db.injections).get(), isEmpty);
    expect(await db.select(db.injectionSites).get(), isEmpty);
    expect(await db.select(db.medications).get(), isEmpty);
    expect(await db.select(db.doseChanges).get(), isEmpty);
  });
}
