import 'dart:convert';

import 'package:drift/drift.dart';

import '../../core/constants/app_constants.dart';
import '../../core/utils/id_generator.dart';
import '../../domain/models/enums.dart';
import '../local/database/app_database.dart';
import '../repositories/profile_repository.dart';

/// Outcome of an import, mirroring the prototype's "Restored N entries" message.
class ImportResult {
  const ImportResult({
    required this.profileId,
    required this.profileName,
    required this.injections,
    required this.growth,
  });

  final String profileId;
  final String profileName;
  final int injections;
  final int growth;
}

class BackupException implements Exception {
  BackupException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Handles JSON export and import, including migrating the original HTML app's
/// `version: 1` backups into a fresh profile.
class BackupService {
  BackupService(this._db, this._profiles, [this._ids = const IdGenerator()]);

  final AppDatabase _db;
  final ProfileRepository _profiles;
  final IdGenerator _ids;

  // --- Detection ---

  static bool looksLikeV1(Map<String, dynamic> json) {
    return json['version'] == 1 &&
        json['injectionHistory'] is List &&
        json['growthHistory'] is List;
  }

  static bool looksLikeV2(Map<String, dynamic> json) {
    return json['version'] == 2 && json['profile'] is Map;
  }

  // --- Import (v1 → current schema) ---

  /// Imports a `version: 1` backup into a brand-new profile. The seeded site
  /// keys match the original app, so historical injections resolve directly.
  Future<ImportResult> importV1(Map<String, dynamic> json) async {
    if (!looksLikeV1(json)) {
      throw BackupException("That file isn't a version 1 backup.");
    }

    final name = (json['childName'] as String?)?.trim();
    final unitSystem =
        json['growthUnit'] == 'metric' ? UnitSystem.metric : UnitSystem.imperial;
    final dose = json['currentDose'] as Map<String, dynamic>?;
    final doseValue =
        dose == null ? null : double.tryParse('${dose['value']}');
    final doseUnit = DoseUnit.fromName(dose?['unit'] as String?);

    final injectionHistory =
        (json['injectionHistory'] as List).cast<Map<String, dynamic>>();
    final growthHistory =
        (json['growthHistory'] as List).cast<Map<String, dynamic>>();

    // Create the profile (this also seeds the six sites + medication + dose).
    final profileId = await _profiles.createFromDraft(
      ProfileDraft(
        name: (name == null || name.isEmpty) ? 'Imported' : name,
        unitSystem: unitSystem,
        medicationName: 'Medication',
        doseValue: doseValue,
        doseUnit: doseUnit,
      ),
    );

    // Map original site keys to the freshly-seeded site ids.
    final sites = await (_db.select(_db.injectionSites)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final siteIdByKey = {for (final s in sites) s.siteKey: s.id};
    final medication = await (_db.select(_db.medications)
          ..where((t) => t.profileId.equals(profileId))
          ..limit(1))
        .getSingleOrNull();

    var importedInjections = 0;
    var importedGrowth = 0;

    await _db.transaction(() async {
      for (final h in injectionHistory) {
        final siteKey = h['site'] as String?;
        final siteId = siteKey == null ? null : siteIdByKey[siteKey];
        final date = _parseDate(h['date'] as String?);
        if (siteId == null || date == null) continue;
        await _db.into(_db.injections).insert(
              InjectionsCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                siteId: siteId,
                medicationId: Value(medication?.id),
                injectedAt: date,
                doseValue: Value(double.tryParse('${h['doseValue'] ?? ''}')),
                doseUnit: Value(
                  (h['doseUnit'] as String?)?.isEmpty ?? true
                      ? null
                      : DoseUnit.fromName(h['doseUnit'] as String?).name,
                ),
                notes: Value(h['notes'] as String?),
                createdAt: DateTime.now(),
              ),
            );
        importedInjections++;
      }

      for (final g in growthHistory) {
        final date = _parseDate(g['date'] as String?);
        if (date == null) continue;
        final height = (g['heightCm'] as num?)?.toDouble();
        final weight = (g['weightKg'] as num?)?.toDouble();
        if (height == null && weight == null) continue;
        await _db.into(_db.growthEntries).insert(
              GrowthEntriesCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                measuredAt: date,
                heightCm: Value(height),
                weightKg: Value(weight),
                notes: Value(g['notes'] as String?),
                source: const Value('imported'),
              ),
            );
        importedGrowth++;
      }
    });

    return ImportResult(
      profileId: profileId,
      profileName: (name == null || name.isEmpty) ? 'Imported' : name,
      injections: importedInjections,
      growth: importedGrowth,
    );
  }

  // --- Import (v2 → new profile) ---

  /// Imports a v2 backup into a new profile, preserving the dose timeline,
  /// injections (mapped by site key) and growth history.
  Future<ImportResult> importV2(Map<String, dynamic> json) async {
    if (!looksLikeV2(json)) {
      throw BackupException("That file isn't a version 2 backup.");
    }
    final p = json['profile'] as Map<String, dynamic>;
    final medJson = json['medication'] as Map<String, dynamic>?;
    final name = (p['name'] as String?)?.trim();
    final displayName = (name == null || name.isEmpty) ? 'Imported' : name;

    final doseChanges =
        (json['doseChanges'] as List? ?? const []).cast<Map<String, dynamic>>();
    final injectionHistory = (json['injectionHistory'] as List? ?? const [])
        .cast<Map<String, dynamic>>();
    final growthHistory = (json['growthHistory'] as List? ?? const [])
        .cast<Map<String, dynamic>>();

    // Parse the schedule from the medication config.
    var scheduleType = ScheduleType.fromName(medJson?['scheduleType'] as String?);
    var everyN = 1;
    var weekdays = <int>{};
    try {
      final cfg = jsonDecode((medJson?['scheduleConfig'] as String?) ?? '{}')
          as Map<String, dynamic>;
      everyN = (cfg['n'] as num?)?.toInt() ?? 1;
      weekdays =
          (cfg['weekdays'] as List?)?.map((e) => e as int).toSet() ?? {};
    } catch (_) {
      scheduleType = ScheduleType.daily;
    }

    // Create the profile (seeds sites + a medication) without an initial dose;
    // the dose timeline below is authoritative.
    final profileId = await _profiles.createFromDraft(
      ProfileDraft(
        name: displayName,
        unitSystem: UnitSystem.fromName(p['unitSystem'] as String?),
        sex: Sex.fromName(p['sex'] as String?),
        dateOfBirth: _parseDate(p['dateOfBirth'] as String?),
        healthcareProvider: p['healthcareProvider'] as String?,
        medicationName: (medJson?['name'] as String?) ?? 'Medication',
        scheduleType: scheduleType,
        everyNDays: everyN,
        weekdays: weekdays,
        reminderTime: medJson?['reminderTime'] as String?,
      ),
    );

    final sites = await (_db.select(_db.injectionSites)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final siteIdByKey = {for (final s in sites) s.siteKey: s.id};
    final medication = await (_db.select(_db.medications)
          ..where((t) => t.profileId.equals(profileId))
          ..limit(1))
        .getSingleOrNull();

    var importedInjections = 0;
    var importedGrowth = 0;
    DoseChangeRow? latestDose;

    await _db.transaction(() async {
      // Dose timeline.
      for (final d in doseChanges) {
        final when = _parseDate(d['effectiveFrom'] as String?);
        final value = (d['value'] as num?)?.toDouble();
        if (when == null || value == null) continue;
        await _db.into(_db.doseChanges).insert(
              DoseChangesCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                medicationId: medication?.id ?? _ids.next(),
                value: value,
                unit: DoseUnit.fromName(d['unit'] as String?).name,
                effectiveFrom: when,
                reason: Value(d['reason'] as String?),
              ),
            );
      }
      // Update medication default to the latest dose.
      latestDose = await (_db.select(_db.doseChanges)
            ..where((t) => t.profileId.equals(profileId))
            ..orderBy([
              (t) => OrderingTerm(
                  expression: t.effectiveFrom, mode: OrderingMode.desc),
            ])
            ..limit(1))
          .getSingleOrNull();
      if (latestDose != null && medication != null) {
        await (_db.update(_db.medications)
              ..where((t) => t.id.equals(medication.id)))
            .write(MedicationsCompanion(
          defaultDoseValue: Value(latestDose!.value),
          defaultDoseUnit: Value(latestDose!.unit),
        ));
      }

      // Injections.
      for (final h in injectionHistory) {
        final siteId = siteIdByKey[h['siteKey'] as String?];
        final date = _parseDate(h['date'] as String?);
        if (siteId == null || date == null) continue;
        await _db.into(_db.injections).insert(
              InjectionsCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                siteId: siteId,
                medicationId: Value(medication?.id),
                injectedAt: date,
                doseValue: Value((h['doseValue'] as num?)?.toDouble()),
                doseUnit: Value(h['doseUnit'] as String?),
                notes: Value(h['notes'] as String?),
                skipped: Value(h['skipped'] as bool? ?? false),
                createdAt: DateTime.now(),
              ),
            );
        importedInjections++;
      }

      // Growth.
      for (final g in growthHistory) {
        final date = _parseDate(g['date'] as String?);
        if (date == null) continue;
        final height = (g['heightCm'] as num?)?.toDouble();
        final weight = (g['weightKg'] as num?)?.toDouble();
        if (height == null && weight == null) continue;
        await _db.into(_db.growthEntries).insert(
              GrowthEntriesCompanion.insert(
                id: _ids.next(),
                profileId: profileId,
                measuredAt: date,
                heightCm: Value(height),
                weightKg: Value(weight),
                notes: Value(g['notes'] as String?),
                source: const Value('imported'),
              ),
            );
        importedGrowth++;
      }
    });

    return ImportResult(
      profileId: profileId,
      profileName: displayName,
      injections: importedInjections,
      growth: importedGrowth,
    );
  }

  // --- Export (current profile → v2 JSON) ---

  Future<Map<String, dynamic>> exportProfile(String profileId) async {
    final profile = await (_db.select(_db.profiles)
          ..where((t) => t.id.equals(profileId)))
        .getSingle();
    final medication = await (_db.select(_db.medications)
          ..where((t) => t.profileId.equals(profileId))
          ..limit(1))
        .getSingleOrNull();
    final sites = await (_db.select(_db.injectionSites)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final injections = await (_db.select(_db.injections)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final growth = await (_db.select(_db.growthEntries)
          ..where((t) => t.profileId.equals(profileId)))
        .get();
    final doses = await (_db.select(_db.doseChanges)
          ..where((t) => t.profileId.equals(profileId)))
        .get();

    final siteKeyById = {for (final s in sites) s.id: s.siteKey};

    return {
      'app': AppConstants.backupApp,
      'version': AppConstants.backupVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'profile': {
        'name': profile.name,
        'unitSystem': profile.unitSystem,
        'sex': profile.sex,
        'dateOfBirth': profile.dateOfBirth?.toIso8601String(),
        'healthcareProvider': profile.healthcareProvider,
      },
      'medication': medication == null
          ? null
          : {
              'name': medication.name,
              'scheduleType': medication.scheduleType,
              'scheduleConfig': medication.scheduleConfig,
              'reminderTime': medication.reminderTime,
              'defaultDoseUnit': medication.defaultDoseUnit,
            },
      'doseChanges': [
        for (final d in doses)
          {
            'value': d.value,
            'unit': d.unit,
            'effectiveFrom': d.effectiveFrom.toIso8601String(),
            'reason': d.reason,
          },
      ],
      'injectionHistory': [
        for (final i in injections)
          {
            'date': i.injectedAt.toIso8601String(),
            'siteKey': siteKeyById[i.siteId],
            'doseValue': i.doseValue,
            'doseUnit': i.doseUnit,
            'notes': i.notes,
            'skipped': i.skipped,
          },
      ],
      'growthHistory': [
        for (final g in growth)
          {
            'date': g.measuredAt.toIso8601String(),
            'heightCm': g.heightCm,
            'weightKg': g.weightKg,
            'notes': g.notes,
          },
      ],
    };
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) return null;
    // v1 stored "YYYY-MM-DD"; v2 stores full ISO-8601.
    return DateTime.tryParse(value.length == 10 ? '${value}T00:00:00' : value);
  }
}
