import 'dart:io';

import 'package:flutter/material.dart';

/// A circular profile photo, falling back to the first letter of the name.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.name,
    this.avatarPath,
    this.radius = 20,
  });

  final String name;
  final String? avatarPath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = avatarPath != null && File(avatarPath!).existsSync();
    return Semantics(
      label: '$name profile photo',
      image: true,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: theme.colorScheme.primaryContainer,
        backgroundImage: hasImage ? FileImage(File(avatarPath!)) : null,
        child: hasImage
            ? null
            : Text(
                name.isEmpty ? '?' : name.characters.first.toUpperCase(),
                style: TextStyle(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: radius * 0.9,
                ),
              ),
      ),
    );
  }
}
