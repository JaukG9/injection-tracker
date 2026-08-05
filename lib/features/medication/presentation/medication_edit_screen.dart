import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../data/local/database/app_database.dart';
import '../../../data/local/database/seed_sites.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/models/medication_preset.dart';
import '../../rotation/presentation/site_selection_screen.dart';
import 'medication_picker.dart';

/// Edits the active profile's medication: type/preset, name, unit, route and
/// schedule. Dose amount is changed on the dashboard (dose history).
class MedicationEditScreen extends ConsumerStatefulWidget {
  const MedicationEditScreen({super.key});

  @override
  ConsumerState<MedicationEditScreen> createState() =>
      _MedicationEditScreenState();
}

class _MedicationEditScreenState extends ConsumerState<MedicationEditScreen> {
  final _name = TextEditingController();
  final _everyN = TextEditingController(text: '2');
  String? _presetId;
  DoseUnit _unit = DoseUnit.mg;
  InjectionRoute _route = InjectionRoute.subcutaneous;
  ScheduleType _schedule = ScheduleType.daily;
  final Set<int> _weekdays = {};
  bool _loaded = false;

  @override
  void dispose() {
    _name.dispose();
    _everyN.dispose();
    super.dispose();
  }

  void _hydrate(MedicationRow med) {
    if (_loaded) return;
    _name.text = med.name;
    _presetId = med.presetId;
    _unit = DoseUnit.fromName(med.defaultDoseUnit);
    _route = InjectionRoute.fromName(med.route);
    _schedule = ScheduleType.fromName(med.scheduleType);
    try {
      final cfg = jsonDecode(med.scheduleConfig) as Map<String, dynamic>;
      if (cfg['n'] != null) _everyN.text = '${cfg['n']}';
      if (cfg['weekdays'] is List) {
        _weekdays.addAll((cfg['weekdays'] as List).map((e) => e as int));
      }
    } catch (_) {}
    _loaded = true;
  }

  String get _scheduleConfigJson {
    switch (_schedule) {
      case ScheduleType.daily:
        return '{}';
      case ScheduleType.everyNDays:
        return jsonEncode({'n': int.tryParse(_everyN.text.trim()) ?? 2});
      case ScheduleType.specificWeekdays:
        return jsonEncode({'weekdays': _weekdays.toList()..sort()});
    }
  }

  Future<void> _pickPreset() async {
    final preset = await showMedicationPicker(context);
    if (preset == null) return;
    setState(() {
      _presetId = preset.id;
      _unit = preset.defaultUnit;
      _route = preset.route;
      if (!preset.isOther) _name.text = preset.name;
    });
  }

  Future<void> _chooseSites() async {
    final profileId = ref.read(activeProfileIdProvider);
    if (profileId == null) return;
    final siteList = ref.read(sitesProvider).value;
    final current = <String>{
      if (siteList != null)
        for (final s in siteList)
          if (s.isEnabled) s.siteKey,
    };
    final result = await chooseInjectionSites(context, current);
    if (result != null) {
      await ref.read(siteRepositoryProvider).setEnabledByKeys(profileId, result);
    }
  }

  Future<void> _save(MedicationRow med) async {
    await ref.read(medicationRepositoryProvider).updateMedication(
          med.id,
          name: _name.text.trim().isEmpty ? 'Medication' : _name.text.trim(),
          presetId: _presetId,
          defaultUnit: _unit,
          route: _route,
          scheduleType: _schedule,
          scheduleConfigJson: _scheduleConfigJson,
        );
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medication updated')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final med = ref.watch(activeMedicationProvider).value;
    if (med == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    _hydrate(med);
    final preset = presetById(_presetId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication'),
        actions: [
          TextButton(onPressed: () => _save(med), child: const Text('Save')),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: _pickPreset,
            child: InputDecorator(
              decoration: const InputDecoration(labelText: 'Type'),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      preset?.name ?? 'Custom',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
          if (preset != null && preset.note.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 4),
              child: Text(preset.note,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.outline)),
            ),
          const SizedBox(height: 14),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Medication name'),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<DoseUnit>(
                  initialValue: _unit,
                  decoration: const InputDecoration(labelText: 'Dose unit'),
                  items: [
                    for (final u in DoseUnit.values)
                      DropdownMenuItem(value: u, child: Text(u.label)),
                  ],
                  onChanged: (v) => setState(() => _unit = v ?? _unit),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Route', style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          SegmentedButton<InjectionRoute>(
            segments: const [
              ButtonSegment(
                  value: InjectionRoute.subcutaneous,
                  label: Text('Subcutaneous')),
              ButtonSegment(
                  value: InjectionRoute.intramuscular,
                  label: Text('Intramuscular')),
            ],
            selected: {_route},
            onSelectionChanged: (s) => setState(() => _route = s.first),
          ),
          const SizedBox(height: 20),
          Text('Injection sites', style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          Builder(builder: (context) {
            final enabled = (ref.watch(sitesProvider).value ?? const [])
                .where((s) => s.isEnabled)
                .length;
            return Card(
              margin: EdgeInsets.zero,
              child: ListTile(
                leading: const Icon(Icons.my_location_outlined),
                title: Text(enabled == allSiteKeys.length
                    ? 'All areas'
                    : '$enabled of ${allSiteKeys.length} spots'),
                subtitle: const Text('Only these can be chosen when logging'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _chooseSites,
              ),
            );
          }),
          const SizedBox(height: 20),
          Text('Schedule', style: theme.textTheme.labelLarge),
          const SizedBox(height: 6),
          DropdownButtonFormField<ScheduleType>(
            initialValue: _schedule,
            decoration: const InputDecoration(),
            items: const [
              DropdownMenuItem(value: ScheduleType.daily, child: Text('Every day')),
              DropdownMenuItem(
                  value: ScheduleType.everyNDays, child: Text('Every few days')),
              DropdownMenuItem(
                  value: ScheduleType.specificWeekdays,
                  child: Text('Specific weekdays')),
            ],
            onChanged: (v) => setState(() => _schedule = v ?? ScheduleType.daily),
          ),
          if (_schedule == ScheduleType.everyNDays) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _everyN,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Every how many days?',
                hintText: 'e.g. 2',
              ),
            ),
          ],
          if (_schedule == ScheduleType.specificWeekdays) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              children: [
                for (var d = 1; d <= 7; d++)
                  FilterChip(
                    label: Text(_weekdayLabel(d)),
                    selected: _weekdays.contains(d),
                    onSelected: (on) => setState(() {
                      if (on) {
                        _weekdays.add(d);
                      } else {
                        _weekdays.remove(d);
                      }
                    }),
                  ),
              ],
            ),
          ],
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => _save(med),
            child: const Text('Save changes'),
          ),
        ],
      ),
    );
  }

  String _weekdayLabel(int d) =>
      const ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][d];
}
