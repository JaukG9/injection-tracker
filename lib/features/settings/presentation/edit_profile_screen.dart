import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../../domain/models/enums.dart';
import '../../profiles/presentation/avatar_picker.dart';

/// Edits an existing profile's details (name, DOB, sex, provider, units).
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key, required this.profileId});

  final String profileId;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _provider = TextEditingController();

  DateTime? _dob;
  Sex _sex = Sex.unspecified;
  UnitSystem _units = UnitSystem.imperial;
  String? _avatarPath;
  bool _avatarTouched = false;
  bool _loaded = false;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _provider.dispose();
    super.dispose();
  }

  void _hydrate() {
    if (_loaded) return;
    final p = ref
        .read(profilesProvider)
        .value
        ?.where((e) => e.id == widget.profileId)
        .firstOrNull;
    if (p == null) return;
    _name.text = p.name;
    _provider.text = p.healthcareProvider ?? '';
    _dob = p.dateOfBirth;
    _sex = Sex.fromName(p.sex);
    _units = UnitSystem.fromName(p.unitSystem);
    _avatarPath = p.avatarPath;
    _loaded = true;
  }

  Future<void> _changeAvatar() async {
    final choice = await pickAvatarChoice(context, ref,
        allowRemove: _avatarPath != null);
    if (choice == null) return;
    setState(() {
      _avatarTouched = true;
      _avatarPath = choice.remove ? null : choice.path;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repo = ref.read(profileRepositoryProvider);
    await repo.updateProfile(
      widget.profileId,
      name: _name.text.trim(),
      unitSystem: _units,
      sex: _sex,
      healthcareProvider:
          _provider.text.trim().isEmpty ? null : _provider.text.trim(),
      dateOfBirth: _dob,
    );
    if (_avatarTouched) {
      await repo.setAvatar(widget.profileId, _avatarPath);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    _hydrate();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Stack(
                children: [
                  ProfileAvatar(
                    name: _name.text,
                    avatarPath: _avatarPath,
                    radius: 48,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Material(
                      color: Theme.of(context).colorScheme.primary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: _changeAvatar,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(Icons.edit,
                              size: 16,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _name,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Name *'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter a name' : null,
            ),
            const SizedBox(height: 14),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _dob ?? DateTime(now.year - 8),
                  firstDate: DateTime(now.year - 100),
                  lastDate: now,
                );
                if (picked != null) setState(() => _dob = picked);
              },
              child: InputDecorator(
                decoration: const InputDecoration(labelText: 'Date of birth'),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _dob == null
                            ? 'Not set'
                            : DateFormat.yMMMMd().format(_dob!),
                      ),
                    ),
                    if (_dob != null)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() => _dob = null),
                      ),
                    const Icon(Icons.calendar_today_outlined, size: 18),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<Sex>(
              initialValue: _sex,
              decoration: const InputDecoration(labelText: 'Sex'),
              items: const [
                DropdownMenuItem(
                    value: Sex.unspecified, child: Text('Prefer not to say')),
                DropdownMenuItem(value: Sex.female, child: Text('Female')),
                DropdownMenuItem(value: Sex.male, child: Text('Male')),
              ],
              onChanged: (v) => setState(() => _sex = v ?? Sex.unspecified),
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _provider,
              decoration:
                  const InputDecoration(labelText: 'Healthcare provider'),
            ),
            const SizedBox(height: 18),
            Text('Preferred units',
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 6),
            SegmentedButton<UnitSystem>(
              segments: const [
                ButtonSegment(value: UnitSystem.imperial, label: Text('in / lb')),
                ButtonSegment(value: UnitSystem.metric, label: Text('cm / kg')),
              ],
              selected: {_units},
              onSelectionChanged: (s) => setState(() => _units = s.first),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: const Text('Save changes'),
            ),
          ],
        ),
      ),
    );
  }
}
