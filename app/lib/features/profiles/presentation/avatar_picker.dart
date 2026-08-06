import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/providers.dart';

/// Result of the avatar picker: either a new saved path, or a request to
/// remove the current photo.
class AvatarChoice {
  const AvatarChoice.path(this.path) : remove = false;
  const AvatarChoice.remove()
      : path = null,
        remove = true;

  final String? path;
  final bool remove;
}

/// Shows a sheet to choose a photo source (or remove). Returns null if
/// cancelled or no image was picked.
Future<AvatarChoice?> pickAvatarChoice(
  BuildContext context,
  WidgetRef ref, {
  bool allowRemove = false,
}) async {
  final source = await showModalBottomSheet<_Source>(
    context: context,
    showDragHandle: true,
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: const Text('Choose from photos'),
            onTap: () => Navigator.pop(ctx, _Source.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: const Text('Take a photo'),
            onTap: () => Navigator.pop(ctx, _Source.camera),
          ),
          if (allowRemove)
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('Remove photo'),
              onTap: () => Navigator.pop(ctx, _Source.remove),
            ),
        ],
      ),
    ),
  );

  if (source == null) return null;
  if (source == _Source.remove) return const AvatarChoice.remove();

  final path = await ref.read(imageServiceProvider).pickAndSave(
        source == _Source.gallery ? ImageSource.gallery : ImageSource.camera,
      );
  return path == null ? null : AvatarChoice.path(path);
}

enum _Source { gallery, camera, remove }
