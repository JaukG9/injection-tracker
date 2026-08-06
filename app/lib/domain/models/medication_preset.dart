import 'enums.dart';

/// A therapeutic grouping used to organise the preset picker.
enum MedCategory {
  growthHormone('Growth hormone'),
  diabetes('Diabetes'),
  weightManagement('Weight management'),
  fertility('Fertility'),
  hormoneTherapy('Hormone therapy'),
  autoimmune('Autoimmune & biologics'),
  bloodThinner('Blood thinners'),
  boneHealth('Bone health'),
  migraine('Migraine'),
  other('Other');

  const MedCategory(this.label);
  final String label;
}

/// A selectable medication template.
///
/// IMPORTANT: presets intentionally carry NO dose *amount*. Doses are
/// individualised and set by a prescriber; the app only records the value the
/// user was actually prescribed. Presets provide the correct unit, route and
/// the body regions where a medicine of this type is typically given, plus a
/// short, non-prescriptive note.
class MedicationPreset {
  const MedicationPreset({
    required this.id,
    required this.name,
    required this.category,
    required this.route,
    required this.defaultUnit,
    required this.regions,
    this.examples,
    this.note = '',
    this.isOther = false,
  });

  final String id;

  /// Generic / descriptive name (not a brand endorsement).
  final String name;
  final MedCategory category;
  final InjectionRoute route;
  final DoseUnit defaultUnit;

  /// Body regions where this type of injection is typically given.
  final List<BodyRegion> regions;

  /// Common example products, shown only as recognition helper text.
  final String? examples;

  /// A short, non-prescriptive tracking note.
  final String note;

  /// The catch-all free-form entry.
  final bool isOther;

  String get regionsLabel =>
      regions.map(_regionWord).toSet().join(', ');
}

String _regionWord(BodyRegion r) => switch (r) {
      BodyRegion.stomach => 'abdomen',
      BodyRegion.thigh => 'thigh',
      BodyRegion.arm => 'upper arm',
      BodyRegion.buttock => 'buttock',
      BodyRegion.other => 'other',
    };

/// Curated catalog of legitimate, commonly self-injected medicines. Organised
/// by category. Examples are for recognition only and are not endorsements.
const List<MedicationPreset> kMedicationPresets = [
  // --- Growth hormone (the app's original focus) ---
  MedicationPreset(
    id: 'gh_daily',
    name: 'Growth hormone (daily)',
    category: MedCategory.growthHormone,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.arm, BodyRegion.buttock],
    examples: 'e.g. Genotropin, Norditropin, Humatrope, Omnitrope, Saizen',
    note: 'Somatropin, given under the skin. Rotate sites each dose.',
  ),
  MedicationPreset(
    id: 'gh_weekly',
    name: 'Growth hormone (weekly, long-acting)',
    category: MedCategory.growthHormone,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.buttock],
    examples: 'e.g. Skytrofa, Sogroya, Ngenla',
    note: 'Long-acting somatropin, usually once weekly. Rotate sites.',
  ),

  // --- Diabetes ---
  MedicationPreset(
    id: 'insulin',
    name: 'Insulin',
    category: MedCategory.diabetes,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.units,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.arm, BodyRegion.buttock],
    note: 'Given under the skin. Rotate within an area to protect the skin.',
  ),
  MedicationPreset(
    id: 'glp1_diabetes',
    name: 'GLP-1 (diabetes)',
    category: MedCategory.diabetes,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.arm],
    examples: 'e.g. Ozempic, Trulicity, Victoza, Bydureon',
    note: 'Under the skin, often once weekly. Rotate sites.',
  ),

  // --- Weight management ---
  MedicationPreset(
    id: 'glp1_weight',
    name: 'GLP-1 (weight management)',
    category: MedCategory.weightManagement,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.arm],
    examples: 'e.g. Wegovy, Zepbound, Saxenda',
    note: 'Under the skin, usually once weekly. Rotate sites.',
  ),

  // --- Fertility ---
  MedicationPreset(
    id: 'fertility',
    name: 'Fertility injection',
    category: MedCategory.fertility,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.iu,
    regions: [BodyRegion.stomach, BodyRegion.thigh],
    examples: 'e.g. gonadotropins (FSH/LH), hCG triggers',
    note: 'Most are given under the skin of the lower abdomen.',
  ),

  // --- Hormone therapy ---
  MedicationPreset(
    id: 'hormone_im',
    name: 'Hormone therapy (intramuscular)',
    category: MedCategory.hormoneTherapy,
    route: InjectionRoute.intramuscular,
    defaultUnit: DoseUnit.mL,
    regions: [BodyRegion.thigh, BodyRegion.buttock],
    note: 'Into muscle (e.g. thigh or upper-outer buttock). Rotate sides.',
  ),
  MedicationPreset(
    id: 'hormone_sc',
    name: 'Hormone therapy (subcutaneous)',
    category: MedCategory.hormoneTherapy,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mL,
    regions: [BodyRegion.stomach, BodyRegion.thigh],
    note: 'Under the skin. Rotate sites each dose.',
  ),

  // --- Autoimmune & biologics ---
  MedicationPreset(
    id: 'biologic',
    name: 'Biologic',
    category: MedCategory.autoimmune,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh],
    examples: 'e.g. adalimumab, etanercept',
    note: 'Under the skin, typically abdomen or thigh. Rotate sites.',
  ),
  MedicationPreset(
    id: 'methotrexate_sc',
    name: 'Methotrexate (subcutaneous)',
    category: MedCategory.autoimmune,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh],
    note: 'Usually once weekly, under the skin. Rotate sites.',
  ),

  // --- Blood thinners ---
  MedicationPreset(
    id: 'lmwh',
    name: 'Blood thinner (LMWH)',
    category: MedCategory.bloodThinner,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach],
    examples: 'e.g. enoxaparin, dalteparin',
    note: 'Under the skin of the abdomen. Alternate sides; avoid the navel.',
  ),

  // --- Bone health ---
  MedicationPreset(
    id: 'teriparatide',
    name: 'Bone-building injection',
    category: MedCategory.boneHealth,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mcg,
    regions: [BodyRegion.thigh, BodyRegion.stomach],
    examples: 'e.g. teriparatide',
    note: 'Under the skin, often once daily. Rotate sites.',
  ),

  // --- Migraine ---
  MedicationPreset(
    id: 'cgrp',
    name: 'Migraine prevention (CGRP)',
    category: MedCategory.migraine,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.arm],
    examples: 'e.g. erenumab, galcanezumab',
    note: 'Under the skin, usually monthly. Rotate sites.',
  ),

  // --- Other ---
  MedicationPreset(
    id: 'other',
    name: 'Other / not listed',
    category: MedCategory.other,
    route: InjectionRoute.subcutaneous,
    defaultUnit: DoseUnit.mg,
    regions: [BodyRegion.stomach, BodyRegion.thigh, BodyRegion.arm, BodyRegion.buttock],
    note: 'Enter your own details and follow your prescriber’s instructions.',
    isOther: true,
  ),
];

MedicationPreset? presetById(String? id) {
  if (id == null) return null;
  for (final p in kMedicationPresets) {
    if (p.id == id) return p;
  }
  return null;
}
