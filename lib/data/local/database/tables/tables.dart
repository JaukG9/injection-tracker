import 'package:drift/drift.dart';

/// Drift table definitions. Every domain table carries a [profileId] so data
/// for different profiles is fully isolated; repositories always scope queries
/// by the active profile. String UUID primary keys make cross-device backup and
/// future merge/sync tractable.

@DataClassName('ProfileRow')
class Profiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 80)();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();

  /// Stored as [Sex.name].
  TextColumn get sex => text().withDefault(const Constant('unspecified'))();
  TextColumn get avatarPath => text().nullable()();

  /// Stored as [UnitSystem.name].
  TextColumn get unitSystem => text().withDefault(const Constant('imperial'))();

  /// Optional per-profile accent seed colour (ARGB int).
  IntColumn get colorSeed => integer().nullable()();
  TextColumn get healthcareProvider => text().nullable()();

  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MedicationRow')
class Medications extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 120)();

  /// Free-text concentration, e.g. "5 mg/mL".
  TextColumn get concentration => text().nullable()();
  RealColumn get defaultDoseValue => real().nullable()();

  /// Stored as [DoseUnit.name].
  TextColumn get defaultDoseUnit =>
      text().withDefault(const Constant('mg'))();

  /// Stored as [ScheduleType.name].
  TextColumn get scheduleType =>
      text().withDefault(const Constant('daily'))();

  /// JSON blob describing the schedule (e.g. {"n":2} or {"weekdays":[1,3,5]}).
  TextColumn get scheduleConfig =>
      text().withDefault(const Constant('{}'))();

  /// Reminder time of day as "HH:mm", or null for no reminder.
  TextColumn get reminderTime => text().nullable()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  /// Route of administration, stored as [InjectionRoute.name].
  TextColumn get route =>
      text().withDefault(const Constant('subcutaneous'))();

  /// The catalog preset this medication was created from, if any.
  TextColumn get presetId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DoseChangeRow')
class DoseChanges extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get medicationId =>
      text().references(Medications, #id, onDelete: KeyAction.cascade)();
  RealColumn get value => real()();

  /// Stored as [DoseUnit.name].
  TextColumn get unit => text()();
  DateTimeColumn get effectiveFrom => dateTime()();
  TextColumn get reason => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InjectionSiteRow')
class InjectionSites extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();

  /// Stable key matching the original prototype (e.g. "leftThigh").
  TextColumn get siteKey => text()();
  TextColumn get name => text()();

  /// Stored as [BodyRegion.name].
  TextColumn get region => text()();

  /// Stored as [BodyView.name].
  TextColumn get bodyView => text()();

  // Ellipse geometry on the 150x230 body map (from the original SITES array).
  RealColumn get cx => real()();
  RealColumn get cy => real()();
  RealColumn get rx => real()();
  RealColumn get ry => real()();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InjectionRow')
class Injections extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get siteId =>
      text().references(InjectionSites, #id, onDelete: KeyAction.cascade)();
  TextColumn get medicationId => text()
      .references(Medications, #id, onDelete: KeyAction.setNull)
      .nullable()();
  DateTimeColumn get injectedAt => dateTime()();

  // Dose snapshot at the time of injection.
  RealColumn get doseValue => real().nullable()();
  TextColumn get doseUnit => text().nullable()();

  TextColumn get notes => text().nullable()();

  /// JSON array of tag strings.
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  BoolColumn get skipped => boolean().withDefault(const Constant(false))();
  TextColumn get skippedReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GrowthEntryRow')
class GrowthEntries extends Table {
  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(Profiles, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get measuredAt => dateTime()();

  // Canonical units.
  RealColumn get heightCm => real().nullable()();
  RealColumn get weightKg => real().nullable()();

  TextColumn get notes => text().nullable()();

  /// manual / health / clinic.
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get tags => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Singleton-ish app settings (one row, id = 'app').
@DataClassName('AppMetaRow')
class AppMetas extends Table {
  TextColumn get id => text().withDefault(const Constant('app'))();
  TextColumn get activeProfileId => text().nullable()();
  BoolColumn get appLockEnabled =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastBackupAt => dateTime().nullable()();

  /// Stored as ThemeMode.name (system/light/dark).
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
