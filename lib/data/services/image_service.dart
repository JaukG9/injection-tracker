import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

/// Picks a profile photo and stores a copy in the app's documents directory,
/// returning the saved path. Works before a profile exists (uses a uuid name).
class ImageService {
  ImageService();

  final ImagePicker _picker = ImagePicker();
  static const _uuid = Uuid();

  Future<String?> pickAndSave(ImageSource source) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: 600,
      maxHeight: 600,
      imageQuality: 85,
    );
    if (picked == null) return null;

    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docs.path, 'avatars'));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    final dest = p.join(dir.path, '${_uuid.v4()}.jpg');
    await File(picked.path).copy(dest);
    return dest;
  }

  /// Best-effort delete of a stored avatar file.
  Future<void> delete(String? path) async {
    if (path == null) return;
    try {
      final f = File(path);
      if (f.existsSync()) await f.delete();
    } catch (_) {
      // ignore
    }
  }
}
