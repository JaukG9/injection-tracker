// One-off helper: crops the raw 1080x2340 emulator screenshots in ../images to
// a store-compliant 1080x2160 (<= 2:1 aspect ratio), trimming the status bar
// and the gesture pill while keeping all app content.
//
// Run from the `app` directory:  dart run tool/crop_screenshots.dart
import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  final dir = Directory('../images');
  const targetH = 2160;
  const topTrim = 90; // remove the status bar
  for (final entry in dir.listSync()) {
    if (entry is! File || !entry.path.endsWith('.png')) continue;
    final im = img.decodePng(entry.readAsBytesSync());
    if (im == null) continue;
    if (im.height <= targetH) continue; // already compliant
    const y = topTrim;
    final h = (y + targetH <= im.height) ? targetH : im.height - y;
    final cropped = img.copyCrop(im, x: 0, y: y, width: im.width, height: h);
    entry.writeAsBytesSync(img.encodePng(cropped));
    // ignore: avoid_print
    print('cropped ${entry.uri.pathSegments.last} -> ${cropped.width}x${cropped.height}');
  }
}
