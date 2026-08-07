import '../../core/utils/date_utils.dart';
import '../models/enums.dart';

/// A medication schedule reduced to what adherence needs.
class ScheduleSpec {
  const ScheduleSpec({
    required this.type,
    this.everyNDays = 1,
    this.weekdays = const <int>{},
    required this.startedOn,
  });

  final ScheduleType type;

  /// For [ScheduleType.everyNDays]; interval in days (>= 1).
  final int everyNDays;

  /// For [ScheduleType.specificWeekdays]; ISO weekdays (Mon=1 .. Sun=7).
  final Set<int> weekdays;

  /// The first day the schedule is considered active.
  final DateTime startedOn;
}

/// Adherence over a date range.
class AdherenceStats {
  const AdherenceStats({
    required this.expected,
    required this.taken,
    required this.missed,
    required this.currentStreak,
  });

  final int expected;
  final int taken;
  final int missed;

  /// Consecutive scheduled days taken, counting back from the range end.
  final int currentStreak;

  /// Fraction in 0..1; 1.0 when nothing was expected.
  double get rate => expected == 0 ? 1.0 : taken / expected;

  int get percent => (rate * 100).round();
}

/// Pure adherence calculation from a schedule and the days injections happened.
///
/// New in the Flutter rebuild; the prototype had no schedule concept.
class AdherenceService {
  const AdherenceService();

  DateTime _dateOnly(DateTime d) => AppDates.dateOnly(d);

  /// Whether a scheduled [day] has come "due" as of [now], and so an untaken
  /// dose there should count as missed.
  ///
  /// Past days are always due. Today only becomes due once its deadline passes:
  /// [deadlineMinutes] minutes after midnight (e.g. a 20:00 reminder -> 1200),
  /// or, when null, the end of the day (midnight) - so today is never counted
  /// as missed while it is still today. Future days are never due.
  bool isDue(DateTime day, DateTime now, {int? deadlineMinutes}) {
    final d = _dateOnly(day);
    final today = _dateOnly(now);
    if (d.isBefore(today)) return true;
    if (d.isAfter(today)) return false;
    // d == today: due only after the deadline time has passed today.
    if (deadlineMinutes == null) return false; // deadline is end of day
    return now.hour * 60 + now.minute >= deadlineMinutes;
  }

  /// Whether the schedule expects a dose on [day].
  bool isScheduledOn(ScheduleSpec spec, DateTime day) {
    final d = _dateOnly(day);
    final start = _dateOnly(spec.startedOn);
    if (d.isBefore(start)) return false;
    switch (spec.type) {
      case ScheduleType.daily:
        return true;
      case ScheduleType.everyNDays:
        final n = spec.everyNDays < 1 ? 1 : spec.everyNDays;
        return d.difference(start).inDays % n == 0;
      case ScheduleType.specificWeekdays:
        return spec.weekdays.contains(d.weekday);
    }
  }

  /// Computes adherence between [from] and [to] (inclusive) given the set of
  /// dates on which an injection was actually logged.
  ///
  /// When [now] is given, a scheduled day that has not yet come due (see
  /// [isDue]) is treated as still pending: it is left out of both [expected]
  /// and [missed], and does not break the current streak. Taken days always
  /// count, even if logged before the deadline. When [now] is null there is no
  /// grace and every scheduled day in range is counted (historical behaviour).
  AdherenceStats stats({
    required ScheduleSpec spec,
    required Iterable<DateTime> injectionDates,
    required DateTime from,
    required DateTime to,
    DateTime? now,
    int? deadlineMinutes,
  }) {
    final taken = injectionDates.map(_dateOnly).toSet();
    final start = _dateOnly(from);
    final end = _dateOnly(to);

    bool due(DateTime d) =>
        now == null || isDue(d, now, deadlineMinutes: deadlineMinutes);

    var expected = 0;
    var takenCount = 0;
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      if (!isScheduledOn(spec, d)) continue;
      if (taken.contains(d)) {
        expected++;
        takenCount++;
      } else if (due(d)) {
        expected++; // a real miss
      }
      // else: not taken and not yet due -> still pending, don't count it.
    }

    // Current streak: walk backwards over scheduled days from [end].
    var streak = 0;
    for (var d = end; !d.isBefore(start); d = d.subtract(const Duration(days: 1))) {
      if (!isScheduledOn(spec, d)) continue;
      if (taken.contains(d)) {
        streak++;
      } else if (due(d)) {
        break; // a real miss ends the streak
      }
      // else: pending day, skip without breaking the streak.
    }

    return AdherenceStats(
      expected: expected,
      taken: takenCount,
      missed: expected - takenCount,
      currentStreak: streak,
    );
  }
}
