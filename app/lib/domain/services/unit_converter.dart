import '../../core/constants/app_constants.dart';
import '../models/enums.dart';

/// Pure conversions between canonical storage units (cm/kg) and display units.
///
/// Ported from the original prototype's `displayHeight`/`displayWeight` and the
/// inverse used when logging. No I/O, fully unit-tested.
class UnitConverter {
  const UnitConverter._();

  // --- Height ---

  /// Canonical centimetres -> value in the given [system]'s height unit.
  static double heightFromCm(double cm, UnitSystem system) =>
      system.isImperial ? cm / AppConstants.inToCm : cm;

  /// A height value entered in [system]'s unit -> canonical centimetres.
  static double heightToCm(double value, UnitSystem system) =>
      system.isImperial ? value * AppConstants.inToCm : value;

  // --- Weight ---

  /// Canonical kilograms -> value in the given [system]'s weight unit.
  static double weightFromKg(double kg, UnitSystem system) =>
      system.isImperial ? kg / AppConstants.lbToKg : kg;

  /// A weight value entered in [system]'s unit -> canonical kilograms.
  static double weightToKg(double value, UnitSystem system) =>
      system.isImperial ? value * AppConstants.lbToKg : value;

  // --- Labels ---

  static String heightUnitLabel(UnitSystem system) =>
      system.isImperial ? 'in' : 'cm';

  static String weightUnitLabel(UnitSystem system) =>
      system.isImperial ? 'lb' : 'kg';

  /// Formats a canonical height for display, e.g. "54.5 in" / "138.4 cm".
  static String formatHeight(double cm, UnitSystem system, {int decimals = 1}) =>
      '${heightFromCm(cm, system).toStringAsFixed(decimals)} '
      '${heightUnitLabel(system)}';

  /// Formats a canonical weight for display, e.g. "62.3 lb" / "28.3 kg".
  static String formatWeight(double kg, UnitSystem system, {int decimals = 1}) =>
      '${weightFromKg(kg, system).toStringAsFixed(decimals)} '
      '${weightUnitLabel(system)}';
}
