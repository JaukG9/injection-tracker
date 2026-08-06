// Generates the app icon PNGs with the `image` package, then
// `dart run flutter_launcher_icons` turns them into platform icons.
//
// Run: dart run tool/generate_app_icon.dart
import 'dart:io';

import 'package:image/image.dart' as img;

final _white = img.ColorRgba8(255, 255, 255, 255);
final _blue = img.ColorRgba8(0x2C, 0x5F, 0x8A, 255);
final _blueLight = img.ColorRgba8(0x40, 0x79, 0xAA, 255);

const int _size = 1024;

void main() {
  Directory('assets/icon').createSync(recursive: true);

  // The white syringe motif, trimmed to its bounds and rotated.
  var motif = _drawSyringe();
  motif = img.trim(motif, mode: img.TrimMode.transparent);
  final rotated =
      img.copyRotate(motif, angle: -40, interpolation: img.Interpolation.cubic);

  // Full icon: gradient blue background + syringe filling ~78% of the frame.
  final full = img.Image(width: _size, height: _size, numChannels: 4);
  _verticalGradient(full, _blueLight, _blue);
  _compositeFitted(full, rotated, fraction: 0.78);
  File('assets/icon/app_icon.png').writeAsBytesSync(img.encodePng(full));

  // Adaptive foreground: transparent + syringe in the ~60% safe zone.
  final fg = img.Image(width: _size, height: _size, numChannels: 4);
  _compositeFitted(fg, rotated, fraction: 0.60);
  File('assets/icon/app_icon_foreground.png').writeAsBytesSync(img.encodePng(fg));

  // ignore: avoid_print
  print('Wrote assets/icon/app_icon.png and app_icon_foreground.png');
}

/// Draws a clean white syringe pointing down on a transparent canvas.
img.Image _drawSyringe() {
  final c = img.Image(width: _size, height: _size, numChannels: 4);
  const cx = _size ~/ 2;

  // Thumb rest.
  _roundedBar(c, cx, 200, 180, 50, 22);
  // Plunger rod.
  img.fillRect(c, x1: cx - 20, y1: 225, x2: cx + 20, y2: 322, color: _white);
  // Flange.
  _roundedBar(c, cx, 344, 250, 54, 24);
  // Barrel.
  _roundedRect(c, x1: cx - 92, y1: 356, x2: cx + 92, y2: 664, r: 34, color: _white);
  // Graduation ticks (brand blue).
  for (final y in [418, 480, 542, 604]) {
    img.fillRect(c, x1: cx - 92, y1: y, x2: cx - 34, y2: y + 12, color: _blue);
  }
  // Needle hub (tapered down to the needle).
  _trapezoid(c, cx, 664, 184, 66, 46);
  // Needle.
  img.fillRect(c, x1: cx - 10, y1: 710, x2: cx + 10, y2: 812, color: _white);
  // Dose droplet at the tip (centred, connected).
  _triangleDown(c, cx, 812, 22, 34);
  img.fillCircle(c, x: cx, y: 858, radius: 24, color: _white);
  return c;
}

// --- drawing helpers ---

void _verticalGradient(img.Image im, img.Color top, img.Color bottom) {
  for (var y = 0; y < im.height; y++) {
    final t = y / im.height;
    final color = img.ColorRgba8(
      _lerp(top.r, bottom.r, t),
      _lerp(top.g, bottom.g, t),
      _lerp(top.b, bottom.b, t),
      255,
    );
    for (var x = 0; x < im.width; x++) {
      im.setPixel(x, y, color);
    }
  }
}

int _lerp(num a, num b, double t) => (a + (b - a) * t).round();

void _roundedBar(img.Image c, int cx, int cy, int w, int h, int r) {
  _roundedRect(c,
      x1: cx - w ~/ 2,
      y1: cy - h ~/ 2,
      x2: cx + w ~/ 2,
      y2: cy + h ~/ 2,
      r: r,
      color: _white);
}

void _roundedRect(img.Image c,
    {required int x1,
    required int y1,
    required int x2,
    required int y2,
    required int r,
    required img.Color color}) {
  img.fillRect(c, x1: x1 + r, y1: y1, x2: x2 - r, y2: y2, color: color);
  img.fillRect(c, x1: x1, y1: y1 + r, x2: x2, y2: y2 - r, color: color);
  img.fillCircle(c, x: x1 + r, y: y1 + r, radius: r, color: color);
  img.fillCircle(c, x: x2 - r, y: y1 + r, radius: r, color: color);
  img.fillCircle(c, x: x1 + r, y: y2 - r, radius: r, color: color);
  img.fillCircle(c, x: x2 - r, y: y2 - r, radius: r, color: color);
}

void _trapezoid(img.Image c, int cx, int topY, int topW, int botW, int h) {
  for (var i = 0; i <= h; i++) {
    final t = i / h;
    final w = (topW + (botW - topW) * t) / 2;
    img.fillRect(c,
        x1: (cx - w).round(),
        y1: topY + i,
        x2: (cx + w).round(),
        y2: topY + i + 1,
        color: _white);
  }
}

void _triangleDown(img.Image c, int cx, int topY, int halfW, int h) {
  for (var i = 0; i <= h; i++) {
    final w = halfW * (1 - i / h);
    img.fillRect(c,
        x1: (cx - w).round(),
        y1: topY + i,
        x2: (cx + w).round(),
        y2: topY + i + 1,
        color: _white);
  }
}

/// Fits [src] to [fraction] of the frame's longest side and centres it.
void _compositeFitted(img.Image dst, img.Image src, {required double fraction}) {
  final box = _size * fraction;
  final longest = src.width > src.height ? src.width : src.height;
  final factor = box / longest;
  final resized = img.copyResize(src,
      width: (src.width * factor).round(),
      height: (src.height * factor).round(),
      interpolation: img.Interpolation.cubic);
  img.compositeImage(
    dst,
    resized,
    dstX: (dst.width - resized.width) ~/ 2,
    dstY: (dst.height - resized.height) ~/ 2,
  );
}
