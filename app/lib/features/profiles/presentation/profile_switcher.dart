import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../onboarding/presentation/onboarding_screen.dart';

/// Opens the profile switcher bottom sheet.
Future<void> showProfileSwitcher(BuildContext context, WidgetRef ref) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => const _ProfileSwitcherSheet(),
  );
}

class _ProfileSwitcherSheet extends ConsumerWidget {
  const _ProfileSwitcherSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profiles = ref.watch(profilesProvider).value ?? const [];
    final activeId = ref.watch(activeProfileIdProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profiles',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ...profiles.map((p) {
              final isActive = p.id == activeId;
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ProfileAvatar(name: p.name, avatarPath: p.avatarPath),
                title: Text(p.name),
                trailing: isActive
                    ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
                    : (profiles.length > 1
                        ? IconButton(
                            icon: const Icon(Icons.archive_outlined),
                            tooltip: 'Archive',
                            onPressed: () => _confirmArchive(context, ref, p.id, p.name),
                          )
                        : null),
                onTap: isActive
                    ? null
                    : () async {
                        await ref
                            .read(settingsRepositoryProvider)
                            .setActiveProfile(p.id);
                        if (context.mounted) Navigator.pop(context);
                      },
              );
            }),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(child: Icon(Icons.add)),
              title: const Text('Add profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const OnboardingScreen(isInitial: false),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmArchive(
    BuildContext context,
    WidgetRef ref,
    String id,
    String name,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Archive $name?'),
        content: const Text(
          'This hides the profile and its data. It is not permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Archive'),
          ),
        ],
      ),
    );
    if (ok == true) {
      await ref.read(profileRepositoryProvider).archive(id);
    }
  }
}
