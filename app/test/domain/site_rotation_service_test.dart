import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/domain/models/enums.dart';
import 'package:injection_tracker/domain/services/site_rotation_service.dart';

void main() {
  const service = SiteRotationService();
  final now = DateTime(2026, 7, 28);

  final sites = [
    const RotationSite(key: 'leftStomach', name: 'Left Stomach', region: BodyRegion.stomach),
    const RotationSite(key: 'rightStomach', name: 'Right Stomach', region: BodyRegion.stomach),
    const RotationSite(key: 'leftThigh', name: 'Left Thigh', region: BodyRegion.thigh),
    const RotationSite(key: 'rightThigh', name: 'Right Thigh', region: BodyRegion.thigh),
  ];

  group('statusForDays', () {
    test('never used is good', () {
      expect(service.statusForDays(null), SiteStatus.good);
    });
    test('boundaries match the original 6/3 thresholds', () {
      expect(service.statusForDays(6), SiteStatus.good);
      expect(service.statusForDays(5), SiteStatus.recent);
      expect(service.statusForDays(3), SiteStatus.recent);
      expect(service.statusForDays(2), SiteStatus.veryRecent);
      expect(service.statusForDays(0), SiteStatus.veryRecent);
    });
  });

  group('recencies', () {
    test('uses the most recent use per site and counts uses', () {
      final uses = [
        SiteUse(siteKey: 'leftThigh', date: DateTime(2026, 7, 20)),
        SiteUse(siteKey: 'leftThigh', date: DateTime(2026, 7, 26)),
      ];
      final recs = service.recencies(sites, uses, now: now);
      final thigh = recs.firstWhere((r) => r.site.key == 'leftThigh');
      expect(thigh.timesUsed, 2);
      expect(thigh.daysSince, 2); // 28 - 26
      expect(thigh.status, SiteStatus.veryRecent);

      final stomach = recs.firstWhere((r) => r.site.key == 'leftStomach');
      expect(stomach.everUsed, isFalse);
      expect(stomach.status, SiteStatus.good);
    });
  });

  group('suggest', () {
    test('prefers never-used sites (rank wins over any real gap)', () {
      final uses = [
        SiteUse(siteKey: 'leftStomach', date: DateTime(2026, 1, 1)),
      ];
      final s = service.suggest(sites, uses, now: now);
      // rightStomach is first never-used site in list order.
      expect(s!.key, 'rightStomach');
    });

    test('picks the longest-ago site when all used', () {
      final uses = [
        SiteUse(siteKey: 'leftStomach', date: DateTime(2026, 7, 27)),
        SiteUse(siteKey: 'rightStomach', date: DateTime(2026, 7, 10)),
        SiteUse(siteKey: 'leftThigh', date: DateTime(2026, 7, 20)),
        SiteUse(siteKey: 'rightThigh', date: DateTime(2026, 7, 25)),
      ];
      final s = service.suggest(sites, uses, now: now);
      expect(s!.key, 'rightStomach'); // used longest ago
    });

    test('avoidRegion skips same region but never returns null', () {
      final uses = [
        SiteUse(siteKey: 'leftStomach', date: DateTime(2026, 7, 27)),
        SiteUse(siteKey: 'rightStomach', date: DateTime(2026, 7, 26)),
        SiteUse(siteKey: 'leftThigh', date: DateTime(2026, 7, 1)),
        SiteUse(siteKey: 'rightThigh', date: DateTime(2026, 7, 2)),
      ];
      // Longest-ago overall is leftThigh, but avoid thigh -> a stomach site.
      final s = service.suggest(sites, uses, now: now, avoidRegion: BodyRegion.thigh);
      expect(s!.region, BodyRegion.stomach);
    });

    test('returns null for empty site list', () {
      expect(service.suggest(const [], const []), isNull);
    });
  });
}
