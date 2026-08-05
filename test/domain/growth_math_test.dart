import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/domain/models/enums.dart';
import 'package:injection_tracker/domain/services/growth_math.dart';

void main() {
  group('GrowthMath.bmi', () {
    test('computes BMI from canonical units', () {
      // 138.4 cm, 28.3 kg -> 1.384^2 = 1.9155; 28.3/1.9155 = 14.77
      final bmi = GrowthMath.bmi(heightCm: 138.4, weightKg: 28.3);
      expect(bmi, closeTo(14.77, 0.02));
    });

    test('returns null when a value is missing', () {
      expect(GrowthMath.bmi(heightCm: 138.4, weightKg: null), isNull);
      expect(GrowthMath.bmi(heightCm: null, weightKg: 28.3), isNull);
      expect(GrowthMath.bmi(heightCm: 0, weightKg: 28.3), isNull);
    });
  });

  group('GrowthMath.velocity', () {
    test('annualizes height change over the interval', () {
      final prev = GrowthSample(date: DateTime(2026, 1, 1), heightCm: 130);
      final curr = GrowthSample(date: DateTime(2026, 7, 1), heightCm: 133);
      final v = GrowthMath.velocity(prev, curr)!;
      // 181 days, +3 cm -> (3/181)*365.25 = 6.05 cm/yr
      expect(v.days, 181);
      expect(v.deltaCm, closeTo(3, 0.0001));
      expect(v.annualizedCm, closeTo(6.05, 0.02));
      expect(v.isPositive, isTrue);
    });

    test('returns null for missing height or same day', () {
      final a = GrowthSample(date: DateTime(2026, 1, 1), heightCm: 130);
      final b = GrowthSample(date: DateTime(2026, 1, 1), heightCm: 131);
      expect(GrowthMath.velocity(a, b), isNull); // same day
      final c = GrowthSample(date: DateTime(2026, 2, 1)); // no height
      expect(GrowthMath.velocity(a, c), isNull);
    });

    test('formats per unit system', () {
      final prev = GrowthSample(date: DateTime(2026, 1, 1), heightCm: 130);
      final curr = GrowthSample(date: DateTime(2026, 7, 1), heightCm: 133);
      final v = GrowthMath.velocity(prev, curr)!;
      expect(v.formatted(UnitSystem.metric), '+6.1 cm/yr');
      expect(v.formatted(UnitSystem.imperial), '+2.4 in/yr');
    });

    test('series has null first element and sorts by date', () {
      final samples = [
        GrowthSample(date: DateTime(2026, 7, 1), heightCm: 133),
        GrowthSample(date: DateTime(2026, 1, 1), heightCm: 130),
      ];
      final series = GrowthMath.velocitySeries(samples);
      expect(series.length, 2);
      expect(series.first, isNull);
      expect(series[1]!.deltaCm, closeTo(3, 0.0001));
    });
  });
}
