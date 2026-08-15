import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/domain/models/enums.dart';
import 'package:injection_tracker/domain/services/adherence_service.dart';
import 'package:injection_tracker/domain/services/dose_math.dart';

void main() {
  const service = AdherenceService();

  group('AdherenceService (daily)', () {
    final spec = ScheduleSpec(
      type: ScheduleType.daily,
      startedOn: DateTime(2026, 7, 1),
    );

    test('counts expected/taken/missed over a range', () {
      final taken = [
        DateTime(2026, 7, 1),
        DateTime(2026, 7, 2),
        DateTime(2026, 7, 4),
      ];
      final stats = service.stats(
        spec: spec,
        injectionDates: taken,
        from: DateTime(2026, 7, 1),
        to: DateTime(2026, 7, 5),
      );
      expect(stats.expected, 5);
      expect(stats.taken, 3);
      expect(stats.missed, 2);
      expect(stats.percent, 60);
    });

    test('current streak counts back from range end', () {
      final taken = [
        DateTime(2026, 7, 3),
        DateTime(2026, 7, 4),
        DateTime(2026, 7, 5),
      ];
      final stats = service.stats(
        spec: spec,
        injectionDates: taken,
        from: DateTime(2026, 7, 1),
        to: DateTime(2026, 7, 5),
      );
      expect(stats.currentStreak, 3);
    });
  });

  group('AdherenceService (everyNDays / weekdays)', () {
    test('everyNDays only expects doses on interval days', () {
      final spec = ScheduleSpec(
        type: ScheduleType.everyNDays,
        everyNDays: 2,
        startedOn: DateTime(2026, 7, 1),
      );
      expect(service.isScheduledOn(spec, DateTime(2026, 7, 1)), isTrue);
      expect(service.isScheduledOn(spec, DateTime(2026, 7, 2)), isFalse);
      expect(service.isScheduledOn(spec, DateTime(2026, 7, 3)), isTrue);
    });

    test('specificWeekdays uses ISO weekday set', () {
      final spec = ScheduleSpec(
        type: ScheduleType.specificWeekdays,
        weekdays: {1, 3, 5}, // Mon, Wed, Fri
        startedOn: DateTime(2026, 7, 1),
      );
      // 2026-07-06 is a Monday.
      expect(service.isScheduledOn(spec, DateTime(2026, 7, 6)), isTrue);
      expect(service.isScheduledOn(spec, DateTime(2026, 7, 7)), isFalse);
    });

    test('nothing expected before start date', () {
      final spec = ScheduleSpec(
        type: ScheduleType.daily,
        startedOn: DateTime(2026, 7, 10),
      );
      expect(service.isScheduledOn(spec, DateTime(2026, 7, 9)), isFalse);
    });
  });

  group('AdherenceService (only completed days count as missed)', () {
    final spec = ScheduleSpec(
      type: ScheduleType.daily,
      startedOn: DateTime(2026, 7, 1),
    );
    final takenThroughYesterday = [
      for (var d = 1; d <= 4; d++) DateTime(2026, 7, d),
    ];

    test('isDue is true only for days before today', () {
      final now = DateTime(2026, 7, 5, 23, 59);
      expect(service.isDue(DateTime(2026, 7, 4), now), isTrue); // yesterday
      expect(service.isDue(DateTime(2026, 7, 5), now), isFalse); // today
      expect(service.isDue(DateTime(2026, 7, 6), now), isFalse); // future
    });

    test('today is never missed, no matter the time of day', () {
      for (final hour in [0, 10, 20, 23]) {
        final stats = service.stats(
          spec: spec,
          injectionDates: takenThroughYesterday,
          from: DateTime(2026, 7, 1),
          to: DateTime(2026, 7, 5),
          now: DateTime(2026, 7, 5, hour),
        );
        expect(stats.expected, 4, reason: 'today excluded at $hour:00');
        expect(stats.missed, 0, reason: 'today not missed at $hour:00');
        expect(stats.currentStreak, 4);
      }
    });

    test('an untaken day becomes missed once the next day starts', () {
      final stats = service.stats(
        spec: spec,
        injectionDates: takenThroughYesterday, // Jul 1-4 taken, Jul 5 not
        from: DateTime(2026, 7, 1),
        to: DateTime(2026, 7, 6),
        now: DateTime(2026, 7, 6, 0, 1), // just past midnight
      );
      expect(stats.missed, 1); // Jul 5 is now a completed, untaken day
      expect(stats.currentStreak, 0);
    });

    test("today's logged dose still counts as taken", () {
      final stats = service.stats(
        spec: spec,
        injectionDates: [
          DateTime(2026, 7, 3),
          DateTime(2026, 7, 4),
          DateTime(2026, 7, 5),
        ],
        from: DateTime(2026, 7, 1),
        to: DateTime(2026, 7, 5),
        now: DateTime(2026, 7, 5, 10),
      );
      expect(stats.taken, 3);
      expect(stats.missed, 2); // Jul 1 and Jul 2 are past and untaken
      expect(stats.currentStreak, 3);
    });

    test('past missed days still count', () {
      final stats = service.stats(
        spec: spec,
        injectionDates: [
          DateTime(2026, 7, 1),
          DateTime(2026, 7, 2),
          DateTime(2026, 7, 4),
        ],
        from: DateTime(2026, 7, 1),
        to: DateTime(2026, 7, 5),
        now: DateTime(2026, 7, 5, 10),
      );
      expect(stats.missed, 1); // Jul 3 missed; Jul 5 still pending
      expect(stats.expected, 4);
    });
  });

  group('DoseMath.mgPerKg', () {
    test('computes mg/kg only for mg doses with weight', () {
      expect(
        DoseMath.mgPerKg(doseValue: 0.6, unit: DoseUnit.mg, latestWeightKg: 28.3),
        closeTo(0.0212, 0.0001),
      );
      expect(
        DoseMath.mgPerKg(doseValue: 0.6, unit: DoseUnit.iu, latestWeightKg: 28.3),
        isNull,
      );
      expect(
        DoseMath.mgPerKg(doseValue: 0.6, unit: DoseUnit.mg, latestWeightKg: null),
        isNull,
      );
    });
  });
}
