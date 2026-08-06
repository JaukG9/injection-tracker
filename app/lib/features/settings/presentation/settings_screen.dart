import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_card.dart';
import '../../../domain/models/enums.dart';
import '../../about/presentation/about_screen.dart';
import '../../backup/presentation/backup_screen.dart';
import '../../medication/presentation/medication_edit_screen.dart';
import '../../reports/presentation/reports_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profile = ref.watch(activeProfileProvider);
    final themeMode = ref.watch(themeModeProvider);
    final units = ref.watch(activeUnitSystemProvider);
    final settings = ref.read(settingsRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'Profile',
            leading: const Icon(Icons.person_outline),
            trailing: TextButton.icon(
              onPressed: profile == null
                  ? null
                  : () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              EditProfileScreen(profileId: profile.id),
                        ),
                      ),
              icon: const Icon(Icons.edit_outlined, size: 18),
              label: const Text('Edit'),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile?.name ?? 'Not set',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700)),
                if (profile?.dateOfBirth != null)
                  Text('Born ${DateFormat.yMMMMd().format(profile!.dateOfBirth!)}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.outline)),
                if (profile?.healthcareProvider != null &&
                    profile!.healthcareProvider!.isNotEmpty)
                  Text('Provider: ${profile.healthcareProvider}',
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.outline)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _MedicationCard(),
          const SizedBox(height: 16),
          AppCard(
            title: 'Appearance',
            leading: const Icon(Icons.palette_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Theme', style: theme.textTheme.labelLarge),
                const SizedBox(height: 8),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(value: ThemeMode.system, label: Text('System')),
                    ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                    ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
                  ],
                  selected: {themeMode},
                  onSelectionChanged: (s) => settings.setThemeMode(s.first),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: 'Units',
            leading: const Icon(Icons.straighten_outlined),
            child: SegmentedButton<UnitSystem>(
              segments: const [
                ButtonSegment(value: UnitSystem.imperial, label: Text('in / lb')),
                ButtonSegment(value: UnitSystem.metric, label: Text('cm / kg')),
              ],
              selected: {units},
              onSelectionChanged: (s) {
                final id = ref.read(activeProfileIdProvider);
                if (id != null) {
                  ref
                      .read(profileRepositoryProvider)
                      .updateProfile(id, unitSystem: s.first);
                }
              },
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: 'Doctor Report',
            leading: const Icon(Icons.summarize_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generate a PDF summary to print or share with your care team.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const ReportsScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.picture_as_pdf_outlined),
                  label: const Text('Create report'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _SecurityCard(),
          const SizedBox(height: 16),
          const _RemindersCard(),
          const SizedBox(height: 16),
          AppCard(
            title: 'Data & Backup',
            leading: const Icon(Icons.backup_outlined),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Export a backup, or import data from the original web app.',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const BackupScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.backup_outlined),
                  label: const Text('Open Backup & Restore'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: 'Help & About',
            leading: const Icon(Icons.info_outline),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.supportDisclaimer,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const AboutScreen(),
                    ),
                  ),
                  icon: const Icon(Icons.help_outline),
                  label: const Text('How it works & privacy'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              '${AppConstants.appName} · v${AppConstants.appVersion}',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

/// Shows the active medication with its route and a link to edit it.
class _MedicationCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final med = ref.watch(activeMedicationProvider).value;
    final route = InjectionRoute.fromName(med?.route);
    return AppCard(
      title: 'Medication',
      leading: const Icon(Icons.vaccines_outlined),
      trailing: TextButton.icon(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const MedicationEditScreen(),
          ),
        ),
        icon: const Icon(Icons.edit_outlined, size: 18),
        label: const Text('Edit'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(med?.name ?? 'Not set',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          Text(route.label,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline)),
        ],
      ),
    );
  }
}

/// App lock: enable/disable a PIN and optional biometric unlock.
class _SecurityCard extends ConsumerStatefulWidget {
  const _SecurityCard();

  @override
  ConsumerState<_SecurityCard> createState() => _SecurityCardState();
}

class _SecurityCardState extends ConsumerState<_SecurityCard> {
  bool _canBiometric = false;
  bool _biometricOn = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final auth = ref.read(authServiceProvider);
    final can = await auth.canUseBiometrics();
    final on = await auth.biometricEnabled();
    if (mounted) {
      setState(() {
        _canBiometric = can;
        _biometricOn = on;
      });
    }
  }

  Future<String?> _promptForPin({required String title}) async {
    final pin = TextEditingController();
    final confirm = TextEditingController();
    String? error;
    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: pin,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 8,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: 'PIN (4-8 digits)', counterText: ''),
              ),
              TextField(
                controller: confirm,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 8,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    labelText: 'Confirm PIN',
                    counterText: '',
                    errorText: error),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final p = pin.text.trim();
                if (p.length < 4) {
                  setLocal(() => error = 'At least 4 digits');
                } else if (p != confirm.text.trim()) {
                  setLocal(() => error = "PINs don't match");
                } else {
                  Navigator.pop(ctx, p);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    return result;
  }

  Future<void> _enableLock() async {
    final pin = await _promptForPin(title: 'Set a PIN');
    if (pin == null) return;
    final auth = ref.read(authServiceProvider);
    await auth.setPin(pin);
    await ref.read(settingsRepositoryProvider).setAppLockEnabled(true);
    // Keep the current session unlocked.
    ref.read(authenticatedProvider.notifier).unlock();
  }

  Future<void> _disableLock() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Turn off app lock?'),
        content: const Text('Your PIN will be removed.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Turn off')),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(authServiceProvider).clearPin();
    await ref.read(settingsRepositoryProvider).setAppLockEnabled(false);
    if (mounted) setState(() => _biometricOn = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lockEnabled = ref.watch(appLockEnabledProvider);

    return AppCard(
      title: 'Security',
      leading: const Icon(Icons.lock_outline),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('App lock (PIN)'),
            subtitle: Text(lockEnabled
                ? 'Require a PIN to open the app'
                : 'Off'),
            value: lockEnabled,
            onChanged: (v) => v ? _enableLock() : _disableLock(),
          ),
          if (lockEnabled) ...[
            if (_canBiometric)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Unlock with biometrics'),
                secondary: const Icon(Icons.fingerprint),
                value: _biometricOn,
                onChanged: (v) async {
                  await ref.read(authServiceProvider).setBiometricEnabled(v);
                  setState(() => _biometricOn = v);
                },
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.pin_outlined, size: 18),
                label: const Text('Change PIN'),
                onPressed: () async {
                  final pin = await _promptForPin(title: 'Change PIN');
                  if (pin != null) {
                    await ref.read(authServiceProvider).setPin(pin);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('PIN updated')),
                      );
                    }
                  }
                },
              ),
            ),
          ],
          Text(
            'Your data always stays safely on this device.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}

/// Daily injection reminder: toggle + time picker. Schedules a local
/// notification via [NotificationService] and stores the time on the
/// active medication.
class _RemindersCard extends ConsumerWidget {
  const _RemindersCard();

  TimeOfDay _parse(String? hhmm) {
    if (hhmm == null) return const TimeOfDay(hour: 20, minute: 0);
    final parts = hhmm.split(':');
    return TimeOfDay(
      hour: int.tryParse(parts.first) ?? 20,
      minute: int.tryParse(parts.last) ?? 0,
    );
  }

  Future<void> _enable(BuildContext context, WidgetRef ref, TimeOfDay time) async {
    final med = ref.read(activeMedicationProvider).value;
    final profile = ref.read(activeProfileProvider);
    if (med == null) return;
    final service = ref.read(notificationServiceProvider);
    final granted = await service.requestPermission();
    if (!granted) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Notifications are turned off. You can turn them back on in '
                "your phone's settings."),
          ),
        );
      }
      return;
    }
    final hhmm = '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
    await ref.read(medicationRepositoryProvider).setReminderTime(med.id, hhmm);
    await service.scheduleDailyReminder(
      hour: time.hour,
      minute: time.minute,
      title: 'Injection reminder',
      body: profile == null
          ? 'Time to log the injection.'
          : "Time for ${profile.name}'s injection.",
    );
  }

  Future<void> _disable(WidgetRef ref) async {
    final med = ref.read(activeMedicationProvider).value;
    if (med != null) {
      await ref.read(medicationRepositoryProvider).setReminderTime(med.id, null);
    }
    await ref.read(notificationServiceProvider).cancelDailyReminder();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final med = ref.watch(activeMedicationProvider).value;
    final reminderTime = med?.reminderTime;
    final enabled = reminderTime != null;
    final time = _parse(reminderTime);

    return AppCard(
      title: 'Daily Reminder',
      leading: const Icon(Icons.notifications_outlined),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Remind me daily'),
            subtitle: Text(enabled
                ? 'At ${time.format(context)}'
                : 'Off'),
            value: enabled,
            onChanged: (v) async {
              if (v) {
                await _enable(context, ref, time);
              } else {
                await _disable(ref);
              }
            },
          ),
          if (enabled)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                icon: const Icon(Icons.schedule, size: 18),
                label: Text('Change time (${time.format(context)})'),
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (picked != null && context.mounted) {
                    await _enable(context, ref, picked);
                  }
                },
              ),
            ),
          Text(
            'A reminder is a gentle nudge, so it can arrive a little late '
            "depending on your phone's battery settings.",
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
