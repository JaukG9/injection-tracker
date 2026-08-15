import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../app/theme/clinical_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/body_map.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/models/medication_preset.dart';

/// Full injection logging flow: pick a site on the body map, set the date/time,
/// confirm or override the dose, add notes, and save (or mark as skipped).
class LogInjectionScreen extends ConsumerStatefulWidget {
  const LogInjectionScreen({super.key, this.initialSiteKey, this.initialDate});

  final String? initialSiteKey;

  /// If set, the log defaults to this date (keeping the current time of day).
  final DateTime? initialDate;

  @override
  ConsumerState<LogInjectionScreen> createState() =>
      _LogInjectionScreenState();
}

class _LogInjectionScreenState extends ConsumerState<LogInjectionScreen> {
  String? _siteKey;
  DateTime _when = DateTime.now();
  final _dose = TextEditingController();
  final _notes = TextEditingController();
  DoseUnit _doseUnit = DoseUnit.mg;
  bool _skipped = false;
  bool _prefilled = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _siteKey = widget.initialSiteKey;
    if (widget.initialDate != null) {
      final d = widget.initialDate!;
      final now = DateTime.now();
      _when = DateTime(d.year, d.month, d.day, now.hour, now.minute);
    }
  }

  @override
  void dispose() {
    _dose.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _prefill() {
    if (_prefilled) return;
    _siteKey ??= ref.read(suggestedSiteProvider);
    final med = ref.read(activeMedicationProvider).value;
    if (med != null) {
      if (med.defaultDoseValue != null && _dose.text.isEmpty) {
        _dose.text = _fmt(med.defaultDoseValue!);
      }
      _doseUnit = DoseUnit.fromName(med.defaultDoseUnit);
    }
    _prefilled = true;
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _when,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_when),
    );
    setState(() {
      _when = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? _when.hour,
        time?.minute ?? _when.minute,
      );
    });
  }

  Future<void> _save() async {
    final profileId = ref.read(activeProfileIdProvider);
    final sites = ref.read(sitesProvider).value ?? const [];
    if (profileId == null || _siteKey == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please choose an injection site.')),
      );
      return;
    }
    final site = sites.firstWhereOrNull((s) => s.siteKey == _siteKey);
    if (site == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('That site is no longer available.')),
      );
      return;
    }
    setState(() => _saving = true);
    final med = ref.read(activeMedicationProvider).value;
    final doseValue = double.tryParse(_dose.text.trim());

    await ref.read(injectionRepositoryProvider).add(
          profileId: profileId,
          siteId: site.id,
          medicationId: med?.id,
          injectedAt: _when,
          doseValue: _skipped ? null : doseValue,
          doseUnit: _skipped ? null : _doseUnit,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
          skipped: _skipped,
          skippedReason: _skipped && _notes.text.trim().isNotEmpty
              ? _notes.text.trim()
              : null,
        );
    if (!mounted) return;
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _skipped
              ? 'Marked as skipped'
              : 'Logged injection at ${site.name}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _prefill();
    final theme = Theme.of(context);
    final clinical = context.clinical;
    final sites = ref.watch(sitesProvider).value ?? const [];
    final recencies = ref.watch(siteRecenciesProvider);
    final statusByKey = {
      for (final r in recencies) r.site.key: r,
    };

    BodyMapSite toMapSite(InjectionSiteRow s) {
      final rec = statusByKey[s.siteKey];
      final status = rec?.status ?? SiteStatus.good;
      final region = BodyRegion.fromName(s.region);
      final note = rec == null || !rec.everUsed
          ? 'never used'
          : 'used ${AppDates.agoLabel(rec.daysSince!)}';
      return BodyMapSite(
        key: s.siteKey,
        cx: s.cx,
        cy: s.cy,
        rx: s.rx,
        ry: s.ry,
        color: clinical.forStatus(status),
        shortLabel: shortLabelForRegion(region),
        semanticLabel: '${s.name}, $note',
        selected: s.siteKey == _siteKey,
        enabled: s.isEnabled,
      );
    }

    final front = sites
        .where((s) => BodyView.fromName(s.bodyView) == BodyView.front)
        .map(toMapSite)
        .toList();
    final back = sites
        .where((s) => BodyView.fromName(s.bodyView) == BodyView.back)
        .map(toMapSite)
        .toList();

    final selectedName =
        sites.where((s) => s.siteKey == _siteKey).map((s) => s.name).firstOrNull;

    final med = ref.watch(activeMedicationProvider).value;
    final preset = presetById(med?.presetId);
    final route = InjectionRoute.fromName(med?.route);

    return Scaffold(
      appBar: AppBar(title: const Text('Log Injection')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (med != null)
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.vaccines_outlined,
                      size: 18, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${med.name} · ${route.label}'
                      '${preset != null && !preset.isOther ? '\nTypical sites: ${preset.regionsLabel}' : ''}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          _Legend(),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 24.0;
              final mapWidth =
                  (((constraints.maxWidth - gap) / 2).clamp(80.0, 150.0))
                      .toDouble();
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MapColumn(
                    label: 'FRONT',
                    child: BodyMap(
                      sites: front,
                      width: mapWidth,
                      onTapSite: (k) => setState(() => _siteKey = k),
                    ),
                  ),
                  _MapColumn(
                    label: 'BACK',
                    child: BodyMap(
                      sites: back,
                      width: mapWidth,
                      onTapSite: (k) => setState(() => _siteKey = k),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          Center(
            child: selectedName == null
                ? Text(
                    'Tap a site to select it',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.outline,
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle,
                            size: 18,
                            color: theme.colorScheme.onPrimaryContainer),
                        const SizedBox(width: 8),
                        Text(
                          selectedName,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const Divider(height: 32),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.event_outlined),
            title: const Text('Date & time'),
            subtitle: Text(DateFormat('EEE, MMM d, yyyy · h:mm a').format(_when)),
            trailing: const Icon(Icons.chevron_right),
            onTap: _pickDateTime,
          ),
          const SizedBox(height: 8),
          if (!_skipped)
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _dose,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Dose'),
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
                    onChanged: (v) => setState(() => _doseUnit = v ?? _doseUnit),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: InputDecoration(
              labelText: _skipped ? 'Reason (optional)' : 'Notes (optional)',
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Mark as skipped / missed'),
            value: _skipped,
            onChanged: (v) => setState(() => _skipped = v),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: Icon(_skipped ? Icons.event_busy : Icons.check),
            label: Text(_skipped ? 'Save as skipped' : 'Log injection'),
          ),
        ],
      ),
    );
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}

class _MapColumn extends StatelessWidget {
  const _MapColumn({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.outline, letterSpacing: 1)),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _Legend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = context.clinical;
    Widget item(Color color, String label) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 10,
                height: 10,
                decoration:
                    BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 5),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        );
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 6,
      children: [
        item(c.good, 'Good to use'),
        item(c.recent, 'Used recently'),
        item(c.veryRecent, 'Used very recently'),
      ],
    );
  }
}
