import '../../core/constants/app_constants.dart';
import '../../core/utils/date_utils.dart';
import '../models/enums.dart';

/// Minimal view of a site the rotation logic needs.
class RotationSite {
  const RotationSite({
    required this.key,
    required this.name,
    this.region = BodyRegion.other,
  });

  final String key;
  final String name;
  final BodyRegion region;
}

/// A single logged use of a site (date-only matters).
class SiteUse {
  const SiteUse({required this.siteKey, required this.date});

  final String siteKey;
  final DateTime date;
}

/// Computed rotation state for one site.
class SiteRecency {
  const SiteRecency({
    required this.site,
    required this.lastUsed,
    required this.daysSince,
    required this.status,
    required this.timesUsed,
  });

  final RotationSite site;

  /// Date the site was last used, or null if never used.
  final DateTime? lastUsed;

  /// Whole days since last use, or null if never used.
  final int? daysSince;

  final SiteStatus status;
  final int timesUsed;

  bool get everUsed => lastUsed != null;
}

/// Pure site-rotation logic ported from the prototype:
/// `daysSince`, `lastUsedFor`, `colorFor`, and `suggestSite`.
///
/// Kept free of any database or widget dependency so it can be exhaustively
/// unit-tested and reused across the dashboard, rotation screen and reports.
class SiteRotationService {
  const SiteRotationService();

  int _daysSince(DateTime date, DateTime now) =>
      AppDates.daysBetween(date, now);

  /// How many days a site must rest before it counts as "good to use" (green),
  /// scaled to how many sites are actually in the rotation.
  ///
  /// With [siteCount] sites and one injection a day, the site you used longest
  /// ago is about `siteCount - 1` days old. Setting the green threshold to that
  /// (capped at [AppConstants.rotationGreenDays]) means there is always at least
  /// one green site to reach for, while a spot never has to rest longer than a
  /// few days before it frees up again.
  int greenDaysFor(int siteCount) {
    if (siteCount <= 1) return 1;
    final scaled = siteCount - 1;
    return scaled < AppConstants.rotationGreenDays
        ? scaled
        : AppConstants.rotationGreenDays;
  }

  /// The amber ("used recently") threshold, sitting roughly halfway between
  /// fresh and rested so there is always a red -> amber -> green spread.
  int amberDaysFor(int siteCount) {
    final green = greenDaysFor(siteCount);
    final amber = (green / 2).ceil();
    return amber < 1 ? 1 : amber;
  }

  /// Maps whole days since last use to a status, given the green/amber
  /// thresholds for the current rotation. Never used is always good.
  SiteStatus statusForDays(
    int? daysSince, {
    int greenDays = AppConstants.rotationGreenDays,
    int amberDays = AppConstants.rotationAmberDays,
  }) {
    if (daysSince == null) return SiteStatus.good;
    if (daysSince >= greenDays) return SiteStatus.good;
    if (daysSince >= amberDays) return SiteStatus.recent;
    return SiteStatus.veryRecent;
  }

  /// Builds recency state for every site, using the most recent use per site.
  List<SiteRecency> recencies(
    List<RotationSite> sites,
    List<SiteUse> uses, {
    DateTime? now,
  }) {
    final clock = now ?? DateTime.now();
    final greenDays = greenDaysFor(sites.length);
    final amberDays = amberDaysFor(sites.length);
    return sites.map((site) {
      final forSite = uses.where((u) => u.siteKey == site.key).toList();
      DateTime? last;
      for (final u in forSite) {
        if (last == null || u.date.isAfter(last)) last = u.date;
      }
      final days = last == null ? null : _daysSince(last, clock);
      return SiteRecency(
        site: site,
        lastUsed: last,
        daysSince: days,
        status: statusForDays(days, greenDays: greenDays, amberDays: amberDays),
        timesUsed: forSite.length,
      );
    }).toList();
  }

  /// Suggests the best next site: the one used longest ago, with never-used
  /// sites winning (rank [AppConstants.neverUsedRank]). Ties resolve to the
  /// first site in [sites] order, matching the original behaviour.
  RotationSite? suggest(
    List<RotationSite> sites,
    List<SiteUse> uses, {
    DateTime? now,
    BodyRegion? avoidRegion,
  }) {
    if (sites.isEmpty) return null;
    final recs = recencies(sites, uses, now: now);

    int rank(SiteRecency r) => r.daysSince ?? AppConstants.neverUsedRank;

    // Optionally avoid repeating the same region back-to-back (smart v2),
    // but never return null if that filter empties the list.
    final pool = avoidRegion == null
        ? recs
        : recs.where((r) => r.site.region != avoidRegion).toList();
    final candidates = pool.isEmpty ? recs : pool;

    SiteRecency best = candidates.first;
    for (final r in candidates) {
      if (rank(r) > rank(best)) best = r;
    }
    return best.site;
  }
}
