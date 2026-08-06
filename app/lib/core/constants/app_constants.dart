/// App-wide constants ported from the original HTML prototype and extended.
///
/// Measurements are stored canonically in centimetres and kilograms; these
/// factors convert to/from the imperial units shown in the UI.
class AppConstants {
  const AppConstants._();

  /// Full display name shown inside the app (titles, footers, about).
  static const String appName = 'SiteCycle: Injection Tracker';

  /// Short name for tight spots (welcome line, system unlock prompt) and to
  /// match the home-screen launcher label.
  static const String appShortName = 'SiteCycle';
  static const String appVersion = '1.0.0';

  // Unit conversion (matches the original: IN_TO_CM = 2.54, LB_TO_KG = 0.453592).
  static const double inToCm = 2.54;
  static const double lbToKg = 0.453592;

  // Site-rotation recency thresholds, in days (from the original colour logic).
  // never used or >= [rotationGreenDays] -> good (green)
  // >= [rotationAmberDays] -> used recently (amber)
  // otherwise -> used very recently (red)
  static const int rotationGreenDays = 6;
  static const int rotationAmberDays = 3;

  // Sentinel used when ranking never-used sites first in the suggestion logic.
  static const int neverUsedRank = 9999;

  static const double daysPerYear = 365.25;

  // Backup format.
  static const String backupApp = 'Injection Tracker Backup';
  static const int backupVersion = 2;

  static const String supportDisclaimer =
      'This app is just a memory aid. Always follow the injection, rotation, '
      'and growth advice your care team gives you.';
}
