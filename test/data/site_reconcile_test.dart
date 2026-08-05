import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/data/local/database/app_database.dart';
import 'package:injection_tracker/data/repositories/profile_repository.dart';
import 'package:injection_tracker/data/local/database/seed_sites.dart';
import 'package:injection_tracker/data/repositories/site_repository.dart';
import 'package:injection_tracker/domain/models/enums.dart';

void main() {
  late AppDatabase db;
  late ProfileRepository profiles;
  late SiteRepository sites;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    profiles = ProfileRepository(db);
    sites = SiteRepository(db);
  });
  tearDown(() => db.close());

  test('preset route and id are stored on the medication', () async {
    final id = await profiles.createFromDraft(
      ProfileDraft(
        name: 'Kid',
        medicationName: 'Insulin',
        route: InjectionRoute.subcutaneous,
        presetId: 'insulin',
        doseUnit: DoseUnit.units,
      ),
    );
    final med = await db.select(db.medications).getSingle();
    expect(med.profileId, id);
    expect(med.presetId, 'insulin');
    expect(med.route, 'subcutaneous');
    expect(med.defaultDoseUnit, 'units');
  });

  test('ensureCanonicalSites adds new sites to a legacy profile and keeps '
      'existing keys', () async {
    // Simulate a legacy profile that only has the original six sites.
    final id = await profiles.createFromDraft(
      ProfileDraft(name: 'Legacy', medicationName: 'GH'),
    );
    // Delete the newer sites to emulate a pre-upgrade state.
    await (db.delete(db.injectionSites)
          ..where((t) =>
              t.profileId.equals(id) &
              t.siteKey.isIn(
                  ['leftArm', 'rightArm', 'lowerLeftAbdomen', 'lowerRightAbdomen'])))
        .go();
    expect(await sites.getForProfile(id), hasLength(6));

    // Reconcile brings it back to the full canonical set.
    await profiles.ensureCanonicalSites(id);
    final after = await sites.getForProfile(id);
    expect(after, hasLength(10));
    expect(after.map((s) => s.siteKey), containsAll(['leftArm', 'rightArm']));
  });

  test('siteKeysForRegions maps a preset region to its sites', () {
    final thighKeys = siteKeysForRegions([BodyRegion.thigh]);
    expect(thighKeys, {'leftThigh', 'rightThigh'});
    // Unknown/empty falls back to all sites.
    expect(siteKeysForRegions(const []), allSiteKeys);
  });

  test('createFromDraft enables only the chosen sites', () async {
    final id = await profiles.createFromDraft(
      ProfileDraft(
        name: 'ThighOnly',
        medicationName: 'GH',
        enabledSiteKeys: {'leftThigh', 'rightThigh'},
      ),
    );
    final all = await sites.getForProfile(id);
    final enabled = all.where((s) => s.isEnabled).map((s) => s.siteKey).toSet();
    expect(enabled, {'leftThigh', 'rightThigh'});
    // The rest exist but are turned off.
    expect(all.where((s) => !s.isEnabled), hasLength(8));
  });

  test('setEnabledByKeys switches which sites are enabled', () async {
    final id = await profiles.createFromDraft(
      ProfileDraft(name: 'Kid', medicationName: 'GH'),
    );
    await sites.setEnabledByKeys(id, {'leftArm'});
    final enabled = (await sites.getForProfile(id))
        .where((s) => s.isEnabled)
        .map((s) => s.siteKey)
        .toSet();
    expect(enabled, {'leftArm'});
  });
}
