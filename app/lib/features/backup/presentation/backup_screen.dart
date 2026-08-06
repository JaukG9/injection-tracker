import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/services/backup_service.dart';

class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  String? _status;
  bool _busy = false;

  Future<void> _export() async {
    final profileId = ref.read(activeProfileIdProvider);
    if (profileId == null) return;
    setState(() => _busy = true);
    try {
      final data = await ref.read(backupServiceProvider).exportProfile(profileId);
      final name = (data['profile'] as Map)['name'] as String;
      final json = const JsonEncoder.withIndent('  ').convert(data);

      final dir = await getTemporaryDirectory();
      final slug = name.toLowerCase().replaceAll(RegExp('[^a-z0-9]+'), '_');
      final file = File('${dir.path}/${slug}_backup.json');
      await file.writeAsString(json);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: "$name's Injection Tracker backup",
        ),
      );
      _set('Your backup is ready.');
    } catch (e) {
      _set('Export failed: $e', error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _import() async {
    setState(() => _busy = true);
    try {
      const group = XTypeGroup(label: 'JSON backup', extensions: ['json']);
      final file = await openFile(acceptedTypeGroups: [group]);
      if (file == null) {
        setState(() => _busy = false);
        return;
      }
      final content = await file.readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;

      final isV1 = BackupService.looksLikeV1(json);
      final isV2 = BackupService.looksLikeV2(json);
      if (!isV1 && !isV2) {
        _set(
          "This doesn't look like an Injection Tracker backup file.",
          error: true,
        );
        return;
      }

      final confirmed = await _confirmImport();
      if (!confirmed) {
        setState(() => _busy = false);
        return;
      }

      final service = ref.read(backupServiceProvider);
      final result = isV2 ? await service.importV2(json) : await service.importV1(json);
      await ref
          .read(settingsRepositoryProvider)
          .setActiveProfile(result.profileId);
      _set(
        'Imported "${result.profileName}": ${result.injections} injections, '
        '${result.growth} growth entries. Switched to the new profile.',
      );
    } catch (e) {
      _set('Import failed: $e', error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _confirmImport() async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Import backup?'),
            content: const Text(
              'This creates a new, separate profile from the backup. '
              'Your existing profiles are not changed.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Import'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _set(String msg, {bool error = false}) {
    if (!mounted) return;
    setState(() => _status = msg);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: error ? Theme.of(context).colorScheme.error : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'Export',
            leading: const Icon(Icons.upload_file_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Save a copy of this profile's data. Everything lives only "
                  "on this device, so it's worth exporting a backup now and "
                  'then, and before you move to a new phone.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: _busy ? null : _export,
                  icon: const Icon(Icons.ios_share),
                  label: const Text('Export backup'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: 'Import',
            leading: const Icon(Icons.download_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coming from the original web app? Export a backup there, '
                  'then pick that file here. It comes in as its own profile '
                  'that you can switch to anytime.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _busy ? null : _import,
                  icon: const Icon(Icons.file_open_outlined),
                  label: const Text('Import backup file'),
                ),
              ],
            ),
          ),
          if (_status != null) ...[
            const SizedBox(height: 16),
            Text(_status!, style: theme.textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}
