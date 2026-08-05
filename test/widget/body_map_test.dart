import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/core/widgets/body_map.dart';

void main() {
  BodyMapSite site(String key, double cx, double cy) => BodyMapSite(
        key: key,
        cx: cx,
        cy: cy,
        rx: 22,
        ry: 26,
        color: Colors.green,
        shortLabel: 'STO',
        semanticLabel: '$key site',
      );

  testWidgets('tapping inside a site ellipse reports that site key',
      (tester) async {
    String? tapped;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: BodyMap(
              // width == view-box width, so view coords map 1:1 to pixels.
              width: BodyMap.vbWidth,
              sites: [site('leftStomach', 55, 95), site('rightStomach', 95, 95)],
              onTapSite: (k) => tapped = k,
            ),
          ),
        ),
      ),
    );

    // Tap the centre of the left-stomach ellipse.
    await tester.tapAt(const Offset(55, 95));
    expect(tapped, 'leftStomach');

    // Tap the centre of the right-stomach ellipse.
    await tester.tapAt(const Offset(95, 95));
    expect(tapped, 'rightStomach');

    // Tap empty space (top-centre, above the sites) — no selection change.
    tapped = null;
    await tester.tapAt(const Offset(75, 5));
    expect(tapped, isNull);
  });
}
