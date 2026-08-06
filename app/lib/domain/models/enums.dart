/// Shared domain enums. Kept in one place so persistence (Drift) and the UI
/// agree on the stored string values.
library;

/// Dose measurement unit. Stored by its [name] ('mg', 'iu', 'mL' historically;
/// 'mcg' and 'units' added for broader medication support).
enum DoseUnit {
  mg('mg'),
  mcg('mcg'),
  iu('IU'),
  units('units'),
  mL('mL');

  const DoseUnit(this.label);

  /// Human-readable label shown in the UI and exports.
  final String label;

  static DoseUnit fromName(String? value) {
    return DoseUnit.values.firstWhere(
      (u) => u.name == value || u.label == value,
      orElse: () => DoseUnit.mg,
    );
  }
}

/// Route of administration for an injectable.
enum InjectionRoute {
  subcutaneous('Subcutaneous', 'under the skin'),
  intramuscular('Intramuscular', 'into muscle');

  const InjectionRoute(this.label, this.plain);

  final String label;
  final String plain;

  static InjectionRoute fromName(String? value) {
    return InjectionRoute.values.firstWhere(
      (r) => r.name == value,
      orElse: () => InjectionRoute.subcutaneous,
    );
  }
}

/// Measurement system used for display. Data is always stored in cm/kg.
enum UnitSystem {
  imperial,
  metric;

  bool get isImperial => this == UnitSystem.imperial;

  static UnitSystem fromName(String? value) {
    return UnitSystem.values.firstWhere(
      (u) => u.name == value,
      orElse: () => UnitSystem.imperial,
    );
  }
}

/// Biological sex (optional), used for growth percentile charts (Phase 3).
enum Sex {
  male,
  female,
  unspecified;

  static Sex fromName(String? value) {
    return Sex.values.firstWhere(
      (s) => s.name == value,
      orElse: () => Sex.unspecified,
    );
  }
}

/// Region of the body an injection site belongs to.
enum BodyRegion {
  stomach,
  thigh,
  buttock,
  arm,
  other;

  static BodyRegion fromName(String? value) {
    return BodyRegion.values.firstWhere(
      (r) => r.name == value,
      orElse: () => BodyRegion.other,
    );
  }
}

/// Which silhouette a site is drawn on.
enum BodyView {
  front,
  back;

  static BodyView fromName(String? value) {
    return BodyView.values.firstWhere(
      (v) => v.name == value,
      orElse: () => BodyView.front,
    );
  }
}

/// How often a medication should be taken.
enum ScheduleType {
  daily,
  everyNDays,
  specificWeekdays;

  static ScheduleType fromName(String? value) {
    return ScheduleType.values.firstWhere(
      (s) => s.name == value,
      orElse: () => ScheduleType.daily,
    );
  }
}

/// Recency status of an injection site, driving the rotation colour.
enum SiteStatus {
  /// Good to use: never used, or beyond the green threshold.
  good,

  /// Used recently, so use caution.
  recent,

  /// Used very recently, so avoid it.
  veryRecent,
}
