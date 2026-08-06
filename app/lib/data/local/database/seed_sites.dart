import '../../../domain/models/enums.dart';

/// A default injection site definition. Geometry is in the body-map's 150x230
/// view-box and is shared with the [BodyMap] painter so the figure and the
/// tappable markers stay in sync.
class SeedSite {
  const SeedSite({
    required this.key,
    required this.name,
    required this.region,
    required this.view,
    required this.cx,
    required this.cy,
    required this.rx,
    required this.ry,
    required this.sortOrder,
  });

  final String key;
  final String name;
  final BodyRegion region;
  final BodyView view;
  final double cx;
  final double cy;
  final double rx;
  final double ry;
  final int sortOrder;
}

/// The canonical injection sites. Existing keys (leftStomach, rightStomach,
/// leftThigh, rightThigh, leftButtock, rightButtock) are preserved so historical
/// injections keep resolving; upper-arm and lower-abdomen sites are added, and
/// all markers are smaller for more precise placement.
const List<SeedSite> kSeedSites = [
  // Upper arms (subcutaneous, lateral upper arm).
  SeedSite(
    key: 'leftArm',
    name: 'Left Upper Arm',
    region: BodyRegion.arm,
    view: BodyView.front,
    cx: 31,
    cy: 82,
    rx: 9,
    ry: 13,
    sortOrder: 0,
  ),
  SeedSite(
    key: 'rightArm',
    name: 'Right Upper Arm',
    region: BodyRegion.arm,
    view: BodyView.front,
    cx: 119,
    cy: 82,
    rx: 9,
    ry: 13,
    sortOrder: 1,
  ),
  // Abdomen quadrants (around, not on, the navel).
  SeedSite(
    key: 'leftStomach',
    name: 'Upper-Left Abdomen',
    region: BodyRegion.stomach,
    view: BodyView.front,
    cx: 63,
    cy: 96,
    rx: 12,
    ry: 12,
    sortOrder: 2,
  ),
  SeedSite(
    key: 'rightStomach',
    name: 'Upper-Right Abdomen',
    region: BodyRegion.stomach,
    view: BodyView.front,
    cx: 87,
    cy: 96,
    rx: 12,
    ry: 12,
    sortOrder: 3,
  ),
  SeedSite(
    key: 'lowerLeftAbdomen',
    name: 'Lower-Left Abdomen',
    region: BodyRegion.stomach,
    view: BodyView.front,
    cx: 63,
    cy: 120,
    rx: 12,
    ry: 12,
    sortOrder: 4,
  ),
  SeedSite(
    key: 'lowerRightAbdomen',
    name: 'Lower-Right Abdomen',
    region: BodyRegion.stomach,
    view: BodyView.front,
    cx: 87,
    cy: 120,
    rx: 12,
    ry: 12,
    sortOrder: 5,
  ),
  // Thighs (front-outer).
  SeedSite(
    key: 'leftThigh',
    name: 'Left Thigh',
    region: BodyRegion.thigh,
    view: BodyView.front,
    cx: 60,
    cy: 180,
    rx: 12,
    ry: 18,
    sortOrder: 6,
  ),
  SeedSite(
    key: 'rightThigh',
    name: 'Right Thigh',
    region: BodyRegion.thigh,
    view: BodyView.front,
    cx: 90,
    cy: 180,
    rx: 12,
    ry: 18,
    sortOrder: 7,
  ),
  // Buttocks (upper-outer quadrant), shown on the back view.
  SeedSite(
    key: 'leftButtock',
    name: 'Left Buttock',
    region: BodyRegion.buttock,
    view: BodyView.back,
    cx: 60,
    cy: 120,
    rx: 14,
    ry: 15,
    sortOrder: 8,
  ),
  SeedSite(
    key: 'rightButtock',
    name: 'Right Buttock',
    region: BodyRegion.buttock,
    view: BodyView.back,
    cx: 90,
    cy: 120,
    rx: 14,
    ry: 15,
    sortOrder: 9,
  ),
];

/// All canonical site keys.
Set<String> get allSiteKeys => {for (final s in kSeedSites) s.key};

/// Site keys whose region is in [regions] (used to derive a sensible default
/// set of allowed sites from a medication preset).
Set<String> siteKeysForRegions(List<BodyRegion> regions) {
  final set = regions.toSet();
  final keys = {
    for (final s in kSeedSites)
      if (set.contains(s.region)) s.key,
  };
  // Never return an empty set; fall back to all sites.
  return keys.isEmpty ? allSiteKeys : keys;
}
