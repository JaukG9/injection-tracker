import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/status_widgets.dart';
import '../../../domain/models/enums.dart';

/// Shows a dialog to set/change the current dose. Records a DoseChange and
/// updates the medication default.
Future<void> showDoseDialog(BuildContext context, WidgetRef ref) async {
  final med = ref.read(activeMedicationProvider).value;
  final profileId = ref.read(activeProfileIdProvider);
  if (med == null || profileId == null) return;

  final controller = TextEditingController(
    text: med.defaultDoseValue == null
        ? ''
        : _fmt(med.defaultDoseValue!),
  );
  var unit = DoseUnit.fromName(med.defaultDoseUnit);

  final saved = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (ctx, setState) => AlertDialog(
        title: const Text('Change dose'),
        content: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                autofocus: true,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Dose'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<DoseUnit>(
                initialValue: unit,
                decoration: const InputDecoration(labelText: 'Unit'),
                items: [
                  for (final u in DoseUnit.values)
                    DropdownMenuItem(value: u, child: Text(u.label)),
                ],
                onChanged: (v) => setState(() => unit = v ?? unit),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Save'),
          ),
        ],
      ),
    ),
  );

  if (saved != true) return;
  final value = double.tryParse(controller.text.trim());
  if (value == null || value <= 0) return;
  await ref.read(medicationRepositoryProvider).changeDose(
        profileId: profileId,
        medicationId: med.id,
        value: value,
        unit: unit,
      );
}

/// A bottom sheet showing the dose-change timeline.
class DoseHistorySheet extends ConsumerWidget {
  const DoseHistorySheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final changes = ref.watch(doseChangesProvider).value ?? const [];
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dose History',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            if (changes.isEmpty)
              const EmptyState(message: 'No dose changes recorded yet.')
            else
              ...changes.map(
                (c) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  leading: const Icon(Icons.medication_outlined),
                  title: Text('${_fmt(c.value)} ${DoseUnit.fromName(c.unit).label}'),
                  subtitle: Text(
                    '${DateFormat.yMMMd().format(c.effectiveFrom)}'
                    '${c.reason == null ? '' : ' · ${c.reason}'}',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

String _fmt(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
