import 'package:flutter/material.dart';

import '../../../domain/models/medication_preset.dart';

/// Opens the medication catalog and returns the chosen preset (or null).
Future<MedicationPreset?> showMedicationPicker(BuildContext context) {
  return Navigator.of(context).push<MedicationPreset>(
    MaterialPageRoute(builder: (_) => const _MedicationPickerScreen()),
  );
}

class _MedicationPickerScreen extends StatelessWidget {
  const _MedicationPickerScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Group presets by category, preserving catalog order.
    final byCategory = <MedCategory, List<MedicationPreset>>{};
    for (final p in kMedicationPresets) {
      byCategory.putIfAbsent(p.category, () => []).add(p);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Choose medication')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline,
                    size: 18, color: theme.colorScheme.outline),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'These just fill in the unit and the usual injection areas '
                    'for you. Always use the dose and instructions your '
                    'prescriber gave you.',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline),
                  ),
                ),
              ],
            ),
          ),
          for (final entry in byCategory.entries) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 6),
              child: Text(
                entry.key.label.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            ...entry.value.map((p) => _PresetTile(preset: p)),
          ],
        ],
      ),
    );
  }
}

class _PresetTile extends StatelessWidget {
  const _PresetTile({required this.preset});

  final MedicationPreset preset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        title: Text(preset.name,
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (preset.examples != null)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(preset.examples!,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.outline)),
              ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                _chip(context, preset.route.label),
                _chip(context, 'Unit: ${preset.defaultUnit.label}'),
                if (!preset.isOther) _chip(context, preset.regionsLabel),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).pop(preset),
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(label,
          style: theme.textTheme.labelSmall
              ?.copyWith(color: theme.colorScheme.onSecondaryContainer)),
    );
  }
}
