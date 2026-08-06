import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../../data/local/database/seed_sites.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/models/medication_preset.dart';
import '../../medication/presentation/medication_picker.dart';
import '../../profiles/presentation/avatar_picker.dart';
import '../../rotation/presentation/site_selection_screen.dart';

/// First-run flow that captures the profile and creates it. Kept as a single
/// scrollable form for clarity; can be split into a paged stepper later.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key, this.isInitial = true});

  /// True for first-run onboarding; false when pushed to add another profile
  /// (in which case it shows an app bar and pops itself after creating).
  final bool isInitial;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _medication = TextEditingController();
  final _dose = TextEditingController();
  final _provider = TextEditingController();

  DateTime? _dob;
  Sex _sex = Sex.unspecified;
  UnitSystem _units = UnitSystem.imperial;
  DoseUnit _doseUnit = DoseUnit.mg;
  InjectionRoute _route = InjectionRoute.subcutaneous;
  MedicationPreset? _preset;
  // Empty = "all areas". The site chooser starts unselected; the user opts in
  // to the specific spots they use.
  Set<String> _enabledSiteKeys = {};
  ScheduleType _schedule = ScheduleType.daily;
  String? _avatarPath;
  bool _saving = false;

  Future<void> _pickMedication() async {
    final preset = await showMedicationPicker(context);
    if (preset == null) return;
    setState(() {
      _preset = preset;
      _route = preset.route;
      _doseUnit = preset.defaultUnit;
      if (!preset.isOther) _medication.text = preset.name;
    });
  }

  Future<void> _chooseSites() async {
    final result = await chooseInjectionSites(context, _enabledSiteKeys);
    if (result != null) setState(() => _enabledSiteKeys = result);
  }

  Future<void> _pickAvatar() async {
    final choice = await pickAvatarChoice(context, ref,
        allowRemove: _avatarPath != null);
    if (choice == null) return;
    // Every pick here creates a fresh temp file; drop the previous one so we
    // don't leave orphaned images behind.
    final previous = _avatarPath;
    if (previous != null) {
      await ref.read(imageServiceProvider).delete(previous);
    }
    setState(() => _avatarPath = choice.remove ? null : choice.path);
  }

  @override
  void dispose() {
    _name.dispose();
    _medication.dispose();
    _dose.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final draft = ProfileDraft(
      name: _name.text.trim(),
      dateOfBirth: _dob,
      sex: _sex,
      healthcareProvider:
          _provider.text.trim().isEmpty ? null : _provider.text.trim(),
      avatarPath: _avatarPath,
      unitSystem: _units,
      medicationName: _medication.text.trim().isEmpty
          ? (_preset?.name ?? 'Medication')
          : _medication.text.trim(),
      doseValue: double.tryParse(_dose.text.trim()),
      doseUnit: _doseUnit,
      route: _route,
      presetId: _preset?.id,
      enabledSiteKeys: _enabledSiteKeys,
      scheduleType: _schedule,
    );

    final profileId =
        await ref.read(profileRepositoryProvider).createFromDraft(draft);
    final settings = ref.read(settingsRepositoryProvider);
    // Switch to the new profile.
    await settings.setActiveProfile(profileId);
    await settings.setOnboardingComplete(true);

    if (!mounted) return;
    // Initial run: the router redirects to /dashboard when onboarding flips.
    // Add-profile (pushed): pop back to where we came from.
    if (!widget.isInitial && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Switched to ${draft.name}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: widget.isInitial
          ? null
          : AppBar(title: const Text('Add Profile')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  const SizedBox(height: 8),
                  Icon(Icons.vaccines_outlined,
                      size: 44, color: theme.colorScheme.primary),
                  const SizedBox(height: 12),
                  Text(
                      widget.isInitial
                          ? 'Welcome to ${AppConstants.appShortName}'
                          : 'Add a profile',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(
                    widget.isInitial
                        ? "Let's set up the first profile. You can add more "
                            'people and edit everything later.'
                        : 'Create a separate profile with its own history, '
                            'growth log, and settings.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: _pickAvatar,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ProfileAvatar(
                                name: _name.text,
                                avatarPath: _avatarPath,
                                radius: 40,
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor:
                                      theme.colorScheme.primary,
                                  child: Icon(Icons.add,
                                      size: 16,
                                      color: theme.colorScheme.onPrimary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('Add photo (optional)',
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: theme.colorScheme.outline)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _name,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                      hintText: 'e.g. Emma',
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
                  ),
                  const SizedBox(height: 14),
                  _DobField(
                    value: _dob,
                    onChanged: (d) => setState(() => _dob = d),
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<Sex>(
                    initialValue: _sex,
                    decoration:
                        const InputDecoration(labelText: 'Sex (optional)'),
                    items: const [
                      DropdownMenuItem(
                          value: Sex.unspecified, child: Text('Prefer not to say')),
                      DropdownMenuItem(value: Sex.female, child: Text('Female')),
                      DropdownMenuItem(value: Sex.male, child: Text('Male')),
                    ],
                    onChanged: (v) => setState(() => _sex = v ?? Sex.unspecified),
                  ),
                  const SizedBox(height: 14),
                  _MedicationSelector(
                    preset: _preset,
                    onTap: _pickMedication,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _medication,
                    decoration: InputDecoration(
                      labelText: 'Medication name',
                      hintText: 'e.g. Growth hormone',
                      helperText: _preset == null
                          ? 'Pick a type above, or type your own'
                          : null,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _dose,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            labelText: 'Dose (from your prescriber)',
                            hintText: 'e.g. 0.6',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<DoseUnit>(
                          initialValue: _doseUnit,
                          decoration: const InputDecoration(labelText: 'Unit'),
                          items: [
                            for (final u in DoseUnit.values)
                              DropdownMenuItem(value: u, child: Text(u.label)),
                          ],
                          onChanged: (v) =>
                              setState(() => _doseUnit = v ?? DoseUnit.mg),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  DropdownButtonFormField<ScheduleType>(
                    initialValue: _schedule,
                    decoration:
                        const InputDecoration(labelText: 'Injection schedule'),
                    items: const [
                      DropdownMenuItem(
                          value: ScheduleType.daily, child: Text('Every day')),
                      DropdownMenuItem(
                          value: ScheduleType.everyNDays,
                          child: Text('Every few days')),
                      DropdownMenuItem(
                          value: ScheduleType.specificWeekdays,
                          child: Text('Specific weekdays')),
                    ],
                    onChanged: (v) =>
                        setState(() => _schedule = v ?? ScheduleType.daily),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: _chooseSites,
                    child: InputDecorator(
                      decoration:
                          const InputDecoration(labelText: 'Injection sites'),
                      child: Row(
                        children: [
                          Icon(Icons.my_location_outlined,
                              size: 20, color: theme.colorScheme.primary),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _enabledSiteKeys.isEmpty
                                  ? 'All areas (tap to choose specific spots)'
                                  : '${_enabledSiteKeys.length} of ${allSiteKeys.length} spots selected',
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text('Preferred units',
                      style: theme.textTheme.labelLarge
                          ?.copyWith(color: theme.colorScheme.outline)),
                  const SizedBox(height: 6),
                  SegmentedButton<UnitSystem>(
                    segments: const [
                      ButtonSegment(
                          value: UnitSystem.imperial, label: Text('in / lb')),
                      ButtonSegment(
                          value: UnitSystem.metric, label: Text('cm / kg')),
                    ],
                    selected: {_units},
                    onSelectionChanged: (s) => setState(() => _units = s.first),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _provider,
                    decoration: const InputDecoration(
                      labelText: 'Healthcare provider (optional)',
                      hintText: 'e.g. Dr. Rivera',
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _saving ? null : _submit,
                    child: _saving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2))
                        : const Text('Create profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tappable tile that opens the medication catalog and shows the choice.
class _MedicationSelector extends StatelessWidget {
  const _MedicationSelector({required this.preset, required this.onTap});

  final MedicationPreset? preset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: InputDecorator(
        decoration: const InputDecoration(labelText: 'Medication type'),
        child: Row(
          children: [
            Icon(Icons.vaccines_outlined,
                size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: preset == null
                  ? Text('Choose from common medications',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.outline))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(preset!.name,
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                          '${preset!.route.label} · ${preset!.isOther ? 'custom' : preset!.regionsLabel}',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.outline),
                        ),
                      ],
                    ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}

class _DobField extends StatelessWidget {
  const _DobField({required this.value, required this.onChanged});

  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  @override
  Widget build(BuildContext context) {
    final label = value == null
        ? 'Date of birth (optional)'
        : '${value!.year}-${value!.month.toString().padLeft(2, '0')}-${value!.day.toString().padLeft(2, '0')}';
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: value ?? DateTime(now.year - 8),
          firstDate: DateTime(now.year - 100),
          lastDate: now,
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(labelText: 'Date of birth'),
        child: Row(
          children: [
            Expanded(child: Text(label)),
            if (value != null)
              IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () => onChanged(null),
              ),
            const Icon(Icons.calendar_today_outlined, size: 18),
          ],
        ),
      ),
    );
  }
}
