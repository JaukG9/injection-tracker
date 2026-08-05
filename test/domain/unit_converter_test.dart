import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/domain/models/enums.dart';
import 'package:injection_tracker/domain/services/unit_converter.dart';

void main() {
  group('UnitConverter', () {
    test('height round-trips through imperial', () {
      const system = UnitSystem.imperial;
      final cm = UnitConverter.heightToCm(54.5, system);
      expect(cm, closeTo(138.43, 0.01));
      expect(UnitConverter.heightFromCm(cm, system), closeTo(54.5, 0.001));
    });

    test('metric height is identity', () {
      expect(UnitConverter.heightToCm(138.4, UnitSystem.metric), 138.4);
      expect(UnitConverter.heightFromCm(138.4, UnitSystem.metric), 138.4);
    });

    test('weight round-trips through imperial', () {
      const system = UnitSystem.imperial;
      final kg = UnitConverter.weightToKg(62.3, system);
      expect(kg, closeTo(28.26, 0.01));
      expect(UnitConverter.weightFromKg(kg, system), closeTo(62.3, 0.001));
    });

    test('formats with unit labels', () {
      expect(UnitConverter.formatHeight(138.4, UnitSystem.metric), '138.4 cm');
      expect(UnitConverter.formatWeight(28.3, UnitSystem.metric), '28.3 kg');
      expect(
        UnitConverter.formatHeight(138.43, UnitSystem.imperial),
        '54.5 in',
      );
    });
  });
}
