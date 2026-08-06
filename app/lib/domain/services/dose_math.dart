import '../models/enums.dart';

/// Pure dose calculations. Ported from the prototype's `computeMgPerKgText`,
/// which derives an approximate mg/kg from the latest known weight.
class DoseMath {
  const DoseMath._();

  /// Approximate mg/kg for a dose, or null when it can't be computed
  /// (non-mg unit, missing value, or no weight available).
  static double? mgPerKg({
    required double? doseValue,
    required DoseUnit? unit,
    required double? latestWeightKg,
  }) {
    if (doseValue == null || doseValue <= 0) return null;
    if (unit != DoseUnit.mg) return null;
    if (latestWeightKg == null || latestWeightKg <= 0) return null;
    return doseValue / latestWeightKg;
  }
}
