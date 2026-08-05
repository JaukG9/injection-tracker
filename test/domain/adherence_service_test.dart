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
