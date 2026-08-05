import '../../core/constants/app_constants.dart';
import '../../core/utils/date_utils.dart';
import '../models/enums.dart';

/// A single height/weight measurement reduced to what the maths needs.
class GrowthSample {
  const GrowthSample({
    required this.date,
    this.heightCm,
    this.weightKg,
  });

  /// Measurement date (time component ignored).
  final DateTime date;
  final double? heightCm;
  final double? weightKg;
}

/// Result of a growth-velocity calculation between two consecutive samples.
class GrowthVelocity {
  const GrowthVelocity({
    required this.deltaCm,
    required this.annualizedCm,
    required this.days,
  });

  /// Height change between the two samples, in centimetres (may be negative).
  final double deltaCm;

  /// Annualized rate in cm/year.
  final double annualizedCm;

  /// Number of days between the two samples.
  final int days;

  bool get isPositive => deltaCm >= 0;

  /// Annualized rate formatted for the given [system], e.g. "+2.4 in/yr".
  String formatted(UnitSystem system, {int decimals = 1}) {
    final value = system.isImperial
        ? annualizedCm / AppConstants.inToCm
        : annualizedCm;
    final unit = system.isImperial ? 'in/yr' : 'cm/yr';
    final sign = deltaCm >= 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(decimals)} $unit';
  }
}

/// Pure growth calculations: BMI and annualized growth velocity.
///
/// Ported from the prototype's `bmiFor` and the velocity block in
/// `renderGrowthHistory` (`(deltaCm / days) * 365.25`).
class GrowthMath {
  const GrowthMath._();

  /// Whole-day difference between two dates (date-only, DST-safe).
  static int daysBetween(DateTime from, DateTime to) =>
      AppDates.daysBetween(from, to);

  /// Body Mass Index from canonical units, or null if inputs are missing.
  static double? bmi({double? heightCm, double? weightKg}) {
    if (heightCm == null || weightKg == null || heightCm <= 0) return null;
    final m = heightCm / 100.0;
    return weightKg / (m * m);
  }

  /// Annualized height velocity between two chronological samples.
  ///
  /// Returns null when either height is missing or the samples share a date.
  static GrowthVelocity? velocity(GrowthSample previous, GrowthSample current) {
    final h1 = previous.heightCm;
    final h2 = current.heightCm;
    if (h1 == null || h2 == null) return null;
    final days = daysBetween(previous.date, current.date);
    if (days <= 0) return null;
    final deltaCm = h2 - h1;
    final annualizedCm = (deltaCm / days) * AppConstants.daysPerYear;
    return GrowthVelocity(deltaCm: deltaCm, annualizedCm: annualizedCm, days: days);
  }

  /// Velocity for each sample relative to the previous one, in chronological
  /// order. The first element is always null (no prior sample).
  static List<GrowthVelocity?> velocitySeries(List<GrowthSample> samples) {
    final sorted = [...samples]..sort((a, b) => a.date.compareTo(b.date));
    final result = <GrowthVelocity?>[];
    for (var i = 0; i < sorted.length; i++) {
      result.add(i == 0 ? null : velocity(sorted[i - 1], sorted[i]));
    }
    return result;
  }
}
