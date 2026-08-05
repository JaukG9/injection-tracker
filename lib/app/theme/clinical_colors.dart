import 'package:flutter/material.dart';

import '../../domain/models/enums.dart';

/// Status and site-tint colours used by the body map, charts and pills.
///
/// Exposed as a [ThemeExtension] so every surface reads them from the theme and
/// they can differ between light and dark while staying WCAG-AA. Never hardcode
/// these in widgets.
@immutable
class ClinicalColors extends ThemeExtension<ClinicalColors> {
  const ClinicalColors({
    required this.good,
    required this.goodContainer,
    required this.recent,
    required this.recentContainer,
    required this.veryRecent,
    required this.veryRecentContainer,
    required this.stomachTint,
    required this.thighTint,
    required this.buttockTint,
    required this.armTint,
    required this.chartLine,
    required this.chartLineSecondary,
  });

  final Color good; // green, good to use
  final Color goodContainer;
  final Color recent; // amber, used recently
  final Color recentContainer;
  final Color veryRecent; // red, used very recently
  final Color veryRecentContainer;

  final Color stomachTint;
  final Color thighTint;
  final Color buttockTint;
  final Color armTint;

  final Color chartLine;
  final Color chartLineSecondary;

  /// Status colour for a [SiteStatus].
  Color forStatus(SiteStatus status) => switch (status) {
        SiteStatus.good => good,
        SiteStatus.recent => recent,
        SiteStatus.veryRecent => veryRecent,
      };

  Color containerForStatus(SiteStatus status) => switch (status) {
        SiteStatus.good => goodContainer,
        SiteStatus.recent => recentContainer,
        SiteStatus.veryRecent => veryRecentContainer,
      };

  /// Tint for a body region (used by history pills).
  Color forRegion(BodyRegion region) => switch (region) {
        BodyRegion.stomach => stomachTint,
        BodyRegion.thigh => thighTint,
        BodyRegion.buttock => buttockTint,
        BodyRegion.arm => armTint,
        BodyRegion.other => stomachTint,
      };

  static const light = ClinicalColors(
    good: Color(0xFF3E8E5A),
    goodContainer: Color(0xFFE9F6EE),
    recent: Color(0xFFC98A1E),
    recentContainer: Color(0xFFFBF0DC),
    veryRecent: Color(0xFFB23A3A),
    veryRecentContainer: Color(0xFFFBEAEA),
    stomachTint: Color(0xFF2C5F8A),
    thighTint: Color(0xFF3E8E5A),
    buttockTint: Color(0xFFC98A1E),
    armTint: Color(0xFF7A5AA8),
    chartLine: Color(0xFF2C5F8A),
    chartLineSecondary: Color(0xFF3E8E5A),
  );

  static const dark = ClinicalColors(
    good: Color(0xFF6DD79A),
    goodContainer: Color(0xFF1E3A28),
    recent: Color(0xFFE8B65A),
    recentContainer: Color(0xFF3D3117),
    veryRecent: Color(0xFFE87A7A),
    veryRecentContainer: Color(0xFF3D1E1E),
    stomachTint: Color(0xFF7FB2DD),
    thighTint: Color(0xFF6DD79A),
    buttockTint: Color(0xFFE8B65A),
    armTint: Color(0xFFB79BE0),
    chartLine: Color(0xFF7FB2DD),
    chartLineSecondary: Color(0xFF6DD79A),
  );

  @override
  ClinicalColors copyWith({
    Color? good,
    Color? goodContainer,
    Color? recent,
    Color? recentContainer,
    Color? veryRecent,
    Color? veryRecentContainer,
    Color? stomachTint,
    Color? thighTint,
    Color? buttockTint,
    Color? armTint,
    Color? chartLine,
    Color? chartLineSecondary,
  }) {
    return ClinicalColors(
      good: good ?? this.good,
      goodContainer: goodContainer ?? this.goodContainer,
      recent: recent ?? this.recent,
      recentContainer: recentContainer ?? this.recentContainer,
      veryRecent: veryRecent ?? this.veryRecent,
      veryRecentContainer: veryRecentContainer ?? this.veryRecentContainer,
      stomachTint: stomachTint ?? this.stomachTint,
      thighTint: thighTint ?? this.thighTint,
      buttockTint: buttockTint ?? this.buttockTint,
      armTint: armTint ?? this.armTint,
      chartLine: chartLine ?? this.chartLine,
      chartLineSecondary: chartLineSecondary ?? this.chartLineSecondary,
    );
  }

  @override
  ClinicalColors lerp(ThemeExtension<ClinicalColors>? other, double t) {
    if (other is! ClinicalColors) return this;
    return ClinicalColors(
      good: Color.lerp(good, other.good, t)!,
      goodContainer: Color.lerp(goodContainer, other.goodContainer, t)!,
      recent: Color.lerp(recent, other.recent, t)!,
      recentContainer: Color.lerp(recentContainer, other.recentContainer, t)!,
      veryRecent: Color.lerp(veryRecent, other.veryRecent, t)!,
      veryRecentContainer:
          Color.lerp(veryRecentContainer, other.veryRecentContainer, t)!,
      stomachTint: Color.lerp(stomachTint, other.stomachTint, t)!,
      thighTint: Color.lerp(thighTint, other.thighTint, t)!,
      buttockTint: Color.lerp(buttockTint, other.buttockTint, t)!,
      armTint: Color.lerp(armTint, other.armTint, t)!,
      chartLine: Color.lerp(chartLine, other.chartLine, t)!,
      chartLineSecondary:
          Color.lerp(chartLineSecondary, other.chartLineSecondary, t)!,
    );
  }
}

/// Convenience access to [ClinicalColors] from a [BuildContext].
extension ClinicalColorsX on BuildContext {
  ClinicalColors get clinical =>
      Theme.of(this).extension<ClinicalColors>() ?? ClinicalColors.light;
}
