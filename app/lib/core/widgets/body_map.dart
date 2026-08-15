import 'package:flutter/material.dart';

import '../../domain/models/enums.dart';

/// One site rendered on the body map, in the original 150x230 view coordinates.
class BodyMapSite {
  const BodyMapSite({
    required this.key,
    required this.cx,
    required this.cy,
    required this.rx,
    required this.ry,
    required this.color,
    required this.shortLabel,
    required this.semanticLabel,
    this.selected = false,
    this.enabled = true,
  });

  final String key;
  final double cx;
  final double cy;
  final double rx;
  final double ry;
  final Color color;

  /// 3-letter label drawn inside the ellipse (STO / THI / BUT / ARM).
  final String shortLabel;

  /// Full accessibility description (e.g. "Left thigh, used 2 days ago").
  final String semanticLabel;
  final bool selected;

  /// Whether this site is allowed for the current medication. Disabled sites
  /// are shown faintly and cannot be tapped.
  final bool enabled;
}

/// Interactive body silhouette (front or back) with tappable, status-coloured
/// injection sites. Ported from the prototype's SVG diagram to a CustomPainter
/// so it scales crisply and stays accessible.
class BodyMap extends StatelessWidget {
  const BodyMap({
    super.key,
    required this.sites,
    required this.onTapSite,
    this.width = 150,
  });

  /// Original view-box dimensions.
  static const double vbWidth = 150;
  static const double vbHeight = 230;

  final List<BodyMapSite> sites;
  final ValueChanged<String>? onTapSite;
  final double width;

  void _handleTap(Offset local, Size size) {
    if (onTapSite == null) return;
    final vx = local.dx / (size.width / vbWidth);
    final vy = local.dy / (size.height / vbHeight);
    for (final s in sites) {
      if (!s.enabled) continue; // can't inject at a disabled site
      final nx = (vx - s.cx) / s.rx;
      final ny = (vy - s.cy) / s.ry;
      if (nx * nx + ny * ny <= 1.0) {
        onTapSite!(s.key);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final silhouetteFill = theme.colorScheme.surfaceContainerHighest;
    final silhouetteStroke = theme.colorScheme.outlineVariant;
    // High-contrast in BOTH themes: near-black on light, near-white on dark.
    final selectedStroke = theme.colorScheme.onSurface;
    // Marker outline follows the background, so a marker never blends into
    // the selection ring (a hardcoded white outline was invisible in dark mode).
    final markerOutline = theme.colorScheme.surface;

    return SizedBox(
      width: width,
      height: width * (vbHeight / vbWidth),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          return Semantics(
            container: true,
            label: 'Injection site map. ${sites.length} sites.',
            child: GestureDetector(
              onTapUp: (d) => _handleTap(d.localPosition, size),
              child: CustomPaint(
                size: size,
                painter: _BodyMapPainter(
                  sites: sites,
                  silhouetteFill: silhouetteFill,
                  silhouetteStroke: silhouetteStroke,
                  selectedStroke: selectedStroke,
                  markerOutline: markerOutline,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BodyMapPainter extends CustomPainter {
  _BodyMapPainter({
    required this.sites,
    required this.silhouetteFill,
    required this.silhouetteStroke,
    required this.selectedStroke,
    required this.markerOutline,
  });

  final List<BodyMapSite> sites;
  final Color silhouetteFill;
  final Color silhouetteStroke;
  final Color selectedStroke;
  final Color markerOutline;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(
      size.width / BodyMap.vbWidth,
      size.height / BodyMap.vbHeight,
    );

    _drawSilhouette(canvas);
    _drawSites(canvas);
    canvas.restore();
  }

  /// A simple but anatomically legible human figure (head, neck, shoulders,
  /// arms at the sides, torso, and two legs). Works for both front and back.
  void _drawSilhouette(Canvas canvas) {
    final fill = Paint()..color = silhouetteFill;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeJoin = StrokeJoin.round
      ..color = silhouetteStroke;

    // Head + neck.
    final head = Path()
      ..addOval(Rect.fromCircle(center: const Offset(75, 20), radius: 13));
    final neck = _roundedRect(68, 30, 82, 42, 3);

    // Torso + legs as one shape, with broad shoulders that meet the arms.
    final body = Path()
      ..moveTo(44, 48) // left shoulder (outer)
      ..cubicTo(43, 62, 44, 76, 46, 92) // left side down to waist
      ..cubicTo(47, 104, 46, 116, 48, 130) // waist
      ..lineTo(50, 150) // left hip -> outer left leg
      ..cubicTo(49, 185, 50, 205, 52, 224)
      ..lineTo(66, 224) // left foot
      ..cubicTo(67, 205, 68, 175, 70, 150)
      ..lineTo(73, 138) // inner left leg to crotch
      ..lineTo(75, 136)
      ..lineTo(77, 138)
      ..lineTo(80, 150) // inner right leg
      ..cubicTo(82, 175, 83, 205, 84, 224)
      ..lineTo(98, 224) // right foot
      ..cubicTo(100, 205, 101, 185, 100, 150)
      ..lineTo(102, 130) // right hip
      ..cubicTo(104, 116, 103, 104, 104, 92)
      ..cubicTo(106, 76, 107, 62, 106, 48) // right side up to shoulder
      ..cubicTo(96, 42, 54, 42, 44, 48) // shoulder line (dips under the neck)
      ..close();

    // Arms hanging at the sides, tucked under the shoulders.
    final leftArm = _roundedRect(26, 50, 44, 152, 8);
    final rightArm = _roundedRect(106, 50, 124, 152, 8);

    for (final path in [body, leftArm, rightArm, head, neck]) {
      canvas.drawPath(path, fill);
    }
    for (final path in [body, leftArm, rightArm, head, neck]) {
      canvas.drawPath(path, stroke);
    }
  }

  void _drawSites(Canvas canvas) {
    // Draw disabled (not-allowed) sites first, faintly, so allowed ones stand
    // out on top.
    for (final s in sites) {
      if (s.enabled) continue;
      final rect = Rect.fromCenter(
        center: Offset(s.cx, s.cy),
        width: s.rx * 1.5,
        height: s.ry * 1.5,
      );
      canvas.drawOval(
        rect,
        Paint()..color = silhouetteStroke.withValues(alpha: 0.5),
      );
    }
    for (final s in sites) {
      if (!s.enabled) continue;
      final center = Offset(s.cx, s.cy);
      final rect = Rect.fromCenter(
        center: center,
        width: s.rx * 2,
        height: s.ry * 2,
      );
      // Selection is drawn as a detached double ring plus a halo, so it stays
      // obvious against any marker colour in both light and dark themes.
      if (s.selected) {
        canvas.drawOval(
          Rect.fromCenter(
              center: center,
              width: s.rx * 2 + 16,
              height: s.ry * 2 + 16),
          Paint()..color = s.color.withValues(alpha: 0.32),
        );
        // Gap ring in the background colour separates marker from the outline.
        canvas.drawOval(
          Rect.fromCenter(
              center: center,
              width: s.rx * 2 + 7,
              height: s.ry * 2 + 7),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4
            ..color = markerOutline,
        );
        // High-contrast selection ring.
        canvas.drawOval(
          Rect.fromCenter(
              center: center,
              width: s.rx * 2 + 10,
              height: s.ry * 2 + 10),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2.5
            ..color = selectedStroke,
        );
      }
      canvas.drawOval(rect, Paint()..color = s.color);
      canvas.drawOval(
        rect,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = s.selected ? 2 : 1.5
          ..color = markerOutline,
      );
    }
  }

  Path _roundedRect(double l, double t, double r, double b, double radius) {
    return Path()
      ..addRRect(RRect.fromLTRBR(l, t, r, b, Radius.circular(radius)));
  }

  @override
  bool shouldRepaint(_BodyMapPainter old) =>
      old.sites != sites ||
      old.silhouetteFill != silhouetteFill ||
      old.selectedStroke != selectedStroke ||
      old.markerOutline != markerOutline;
}

/// The 3-letter label for a region, matching the prototype (STO/THI/BUT).
String shortLabelForRegion(BodyRegion region) => switch (region) {
      BodyRegion.stomach => 'STO',
      BodyRegion.thigh => 'THI',
      BodyRegion.buttock => 'BUT',
      BodyRegion.arm => 'ARM',
      BodyRegion.other => 'SITE',
    };
