import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/utils/id_generator.dart';
import '../../domain/models/enums.dart';
import '../local/database/app_database.dart';
import '../local/database/seed_sites.dart';

/// Everything captured during onboarding to create the first profile.
class ProfileDraft {
  ProfileDraft({
    required this.name,
    this.dateOfBirth,
    this.sex = Sex.unspecified,
    this.avatarPath,
    this.healthcareProvider,
    this.unitSystem = UnitSystem.imperial,
    required this.medicationName,
    this.doseValue,
    this.doseUnit = DoseUnit.mg,
    this.route = InjectionRoute.subcutaneous,
    this.presetId,
    this.enabledSiteKeys,
    this.scheduleType = ScheduleType.daily,
    this.everyNDays = 1,
    this.weekdays = const <int>{},
    this.reminderTime,
  });

  final String name;
  final DateTime? dateOfBirth;
  final Sex sex;
  final String? avatarPath;
  final String? healthcareProvider;
  final UnitSystem unitSystem;

  final String medicationName;
  final double? doseValue;
  final DoseUnit doseUnit;
  final InjectionRoute route;
  final String? presetId;

  /// The subset of site keys the user allows for this medication. Null means
  /// leave all sites enabled.
  final Set<String>? enabledSiteKeys;
  final ScheduleType scheduleType;
  final int everyNDays;
  final Set<int> weekdays;
  final String? reminderTime; // "HH:mm"

  String get scheduleConfigJson {
    switch (scheduleType) {
      case ScheduleType.daily:
        return '{}';
      case ScheduleType.everyNDays:
        return jsonEncode({'n': everyNDays});
      case ScheduleType.specificWeekdays:
        return jsonEncode({'weekdays': weekdays.toList()..sort()});
    }
  }
}

/// Creates and manages profiles. Profile creation is transactional and seeds
/// the six default injection sites plus the initial medication + dose so the
/// rest of the app has a consistent starting state.
class ProfileRepository {
  ProfileRepository(this._db, [this._ids = const IdGenerator()]);

  final AppDatabase _db;
  final IdGenerator _ids;

  Stream<List<ProfileRow>> watchAll() {
    return (_db.select(_db.profiles)
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
        .watch();
  }

  Future<ProfileRow?> getById(String id) {
    return (_db.select(_db.profiles)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  /// Creates a profile with seeded sites, an active medication, and an initial
  /// dose change. Returns the new profile id.
  Future<String> createFromDraft(ProfileDraft draft) async {
    final now = DateTime.now();
    final profileId = _ids.next();

    await _db.transaction(() async {
      await _db.into(_db.profiles).insert(
            ProfilesCompanion.insert(
              id: profileId,
              name: draft.name,
              dateOfBirth: Value(draft.dateOfBirth),
              sex: Value(draft.sex.name),
              avatarPath: Value(draft.avatarPath),
              unitSystem: Value(draft.unitSystem.name),
              healthcareProvider: Value(draft.healthcareProvider),
              createdAt: now,
              updatedAt: now,
            ),
          );

      // Seed the default injection sites for this profile, enabling only the
      // ones the user allows for this medication (all, if unspecified).
      final enabled = draft.enabledSiteKeys;
      for (final s in kSeedSites) {
        await _db.into(_db.injectionSites).insert(
              InjectionSitesCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                siteKey: s.key,
                name: s.name,
                region: s.region.name,
                bodyView: s.view.name,
                cx: s.cx,
                cy: s.cy,
                rx: s.rx,
                ry: s.ry,
                isEnabled: Value(enabled == null || enabled.contains(s.key)),
                sortOrder: Value(s.sortOrder),
              ),
            );
      }

      // Create the medication.
      final medicationId = _ids.next();
      await _db.into(_db.medications).insert(
            MedicationsCompanion.insert(
              id: medicationId,
              profileId: profileId,
              name: draft.medicationName,
              defaultDoseValue: Value(draft.doseValue),
              defaultDoseUnit: Value(draft.doseUnit.name),
              route: Value(draft.route.name),
              presetId: Value(draft.presetId),
              scheduleType: Value(draft.scheduleType.name),
              scheduleConfig: Value(draft.scheduleConfigJson),
              reminderTime: Value(draft.reminderTime),
              startedAt: Value(now),
            ),
          );

      // Seed the initial dose change if a dose was provided.
      if (draft.doseValue != null) {
        await _db.into(_db.doseChanges).insert(
              DoseChangesCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                medicationId: medicationId,
                value: draft.doseValue!,
                unit: draft.doseUnit.name,
                effectiveFrom: now,
                reason: const Value('Initial dose'),
              ),
            );
      }
    });

    return profileId;
  }

  /// Ensures the profile has the current canonical site set: adds any missing
  /// sites (by key) and refreshes name/region/view/geometry on existing ones,
  /// preserving each site's id and enabled state. Idempotent.
  Future<void> ensureCanonicalSites(String profileId) async {
    final existing = await (_db.select(_db.injectionSites)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final byKey = {for (final s in existing) s.siteKey: s};
    await _db.transaction(() async {
      for (final s in kSeedSites) {
        final current = byKey[s.key];
        if (current == null) {
          await _db.into(_db.injectionSites).insert(
                InjectionSitesCompanion.insert(
                  id: _ids.next(),
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
        } else {
          await (_db.update(_db.injectionSites)
                ..where((t) => t.id.equals(current.id)))
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
        }
      }
    });
  }

  /// Sets or clears (null) the profile's avatar path.
  Future<void> setAvatar(String profileId, String? path) {
    return (_db.update(_db.profiles)..where((t) => t.id.equals(profileId)))
        .write(
      ProfilesCompanion(
        avatarPath: Value(path),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> archive(String profileId) {
    return (_db.update(_db.profiles)..where((t) => t.id.equals(profileId)))
        .write(
      ProfilesCompanion(
        isArchived: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Updates any subset of a profile's editable fields. Fields left as the
  /// sentinel default are untouched; pass [clearDateOfBirth]/[clearProvider] to
  /// explicitly null a value.
  Future<void> updateProfile(
    String profileId, {
    String? name,
    UnitSystem? unitSystem,
    Sex? sex,
    Object? healthcareProvider = _unset,
    Object? dateOfBirth = _unset,
    Object? avatarPath = _unset,
  }) {
    return (_db.update(_db.profiles)..where((t) => t.id.equals(profileId)))
        .write(
      ProfilesCompanion(
        name: name == null ? const Value.absent() : Value(name),
        unitSystem: unitSystem == null
            ? const Value.absent()
            : Value(unitSystem.name),
        sex: sex == null ? const Value.absent() : Value(sex.name),
        healthcareProvider: identical(healthcareProvider, _unset)
            ? const Value.absent()
            : Value(healthcareProvider as String?),
        dateOfBirth: identical(dateOfBirth, _unset)
            ? const Value.absent()
            : Value(dateOfBirth as DateTime?),
        avatarPath: identical(avatarPath, _unset)
            ? const Value.absent()
            : Value(avatarPath as String?),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }
}

/// Sentinel distinguishing "leave unchanged" from "set to null".
const Object _unset = Object();
