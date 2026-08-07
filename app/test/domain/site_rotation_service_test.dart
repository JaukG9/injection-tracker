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
    test('boundaries match the default 4/2 thresholds', () {
      expect(service.statusForDays(4), SiteStatus.good);
      expect(service.statusForDays(3), SiteStatus.recent);
      expect(service.statusForDays(2), SiteStatus.recent);
      expect(service.statusForDays(1), SiteStatus.veryRecent);
      expect(service.statusForDays(0), SiteStatus.veryRecent);
    });
    test('honours explicit thresholds', () {
      expect(service.statusForDays(2, greenDays: 2, amberDays: 1),
          SiteStatus.good);
      expect(service.statusForDays(1, greenDays: 2, amberDays: 1),
          SiteStatus.recent);
    });
  });

  group('threshold scaling', () {
    test('green threshold is siteCount - 1, capped at 4', () {
      expect(service.greenDaysFor(2), 1);
      expect(service.greenDaysFor(4), 3);
      expect(service.greenDaysFor(5), 4);
      expect(service.greenDaysFor(6), 4);
      expect(service.greenDaysFor(10), 4);
      expect(service.greenDaysFor(1), 1);
    });
    test('amber threshold is about half of green, at least 1', () {
      expect(service.amberDaysFor(6), 2); // green 4 -> 2
      expect(service.amberDaysFor(4), 2); // green 3 -> 2
      expect(service.amberDaysFor(2), 1); // green 1 -> 1
    });
    test('a perfectly rotated set always has at least one green site', () {
      // Build N sites, each last used on a distinct consecutive day, oldest
      // exactly siteCount - 1 days ago (daily rotation, none used today).
      for (final n in [2, 3, 4, 6, 8, 10]) {
        final s = List.generate(
            n, (i) => RotationSite(key: 'site$i', name: 'Site $i'));
        final uses = List.generate(
            n, (i) => SiteUse(siteKey: 'site$i', date: now.subtract(Duration(days: i + 1))));
        final recs = service.recencies(s, uses, now: now);
        expect(recs.any((r) => r.status == SiteStatus.good), isTrue,
            reason: 'expected a green site with $n sites');
      }
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
      // 4 sites -> green 3 / amber 2, so 2 days is "used recently" (amber).
      expect(thigh.status, SiteStatus.recent);

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
