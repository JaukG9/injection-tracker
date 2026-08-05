/// Date-only helpers.
///
/// All day arithmetic is done in UTC. Using local `DateTime.difference().inDays`
/// silently under-counts across a daylight-saving transition (e.g. a spring
/// forward between two dates yields a 23-hour day that truncates to one fewer
/// day). Normalising to UTC midnight makes day math deterministic everywhere.
class AppDates {
  const AppDates._();

  /// The date part of [d] as UTC midnight, discarding time and zone.
  static DateTime dateOnly(DateTime d) => DateTime.utc(d.year, d.month, d.day);

  /// Whole days from [from] to [to] (date-only, DST-safe). Can be negative.
  static int daysBetween(DateTime from, DateTime to) =>
      dateOnly(to).difference(dateOnly(from)).inDays;

  /// Whole days from [date] up to [now] (defaults to today).
  static int daysSince(DateTime date, {DateTime? now}) =>
      daysBetween(date, now ?? DateTime.now());

  /// A friendly, correctly-pluralized label for how long ago something was.
  /// 0 -> 'today', 1 -> 'yesterday', otherwise 'N days ago'.
  static String agoLabel(int days) {
    if (days <= 0) return 'today';
    if (days == 1) return 'yesterday';
    return '$days days ago';
  }

  /// Inclusive list of date-only days from [from] to [to].
  static List<DateTime> range(DateTime from, DateTime to) {
    final start = dateOnly(from);
    final end = dateOnly(to);
    final days = <DateTime>[];
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      days.add(d);
    }
    return days;
  }
}
