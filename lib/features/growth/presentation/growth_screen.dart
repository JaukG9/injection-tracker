import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../app/theme/clinical_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/status_widgets.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/services/growth_math.dart';
import '../../../domain/services/unit_converter.dart';
import '../../charts/presentation/growth_trend_chart.dart';

class GrowthScreen extends ConsumerStatefulWidget {
  const GrowthScreen({super.key});

  @override
  ConsumerState<GrowthScreen> createState() => _GrowthScreenState();
}

class _GrowthScreenState extends ConsumerState<GrowthScreen> {
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _notes = TextEditingController();

  @override
  void dispose() {
    _height.dispose();
    _weight.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _log(UnitSystem units) async {
    final profileId = ref.read(activeProfileIdProvider);
    if (profileId == null) return;
    final h = double.tryParse(_height.text.trim());
    final w = double.tryParse(_weight.text.trim());
    if (h == null && w == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a height and/or weight first.')),
      );
      return;
    }
    await ref.read(growthRepositoryProvider).add(
          profileId: profileId,
          measuredAt: DateTime.now(),
          heightCm: h == null ? null : UnitConverter.heightToCm(h, units),
          weightKg: w == null ? null : UnitConverter.weightToKg(w, units),
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        );
    _height.clear();
    _weight.clear();
    _notes.clear();
    if (mounted) FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final units = ref.watch(activeUnitSystemProvider);
    final entries = ref.watch(growthEntriesProvider).value ?? const [];
    final df = DateFormat('MMM d, yyyy');

    // Velocity is computed over chronological order.
    final chrono = [...entries].reversed.toList();
    final samples = chrono
        .map((e) => GrowthSample(
              date: e.measuredAt,
              heightCm: e.heightCm,
              weightKg: e.weightKg,
            ))
        .toList();
    final velocities = GrowthMath.velocitySeries(samples);
    final velocityByDate = <DateTime, GrowthVelocity?>{
      for (var i = 0; i < chrono.length; i++)
        chrono[i].measuredAt: velocities[i],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Growth Tracker')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'Log Height & Weight',
            leading: const Icon(Icons.straighten),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _height,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText:
                              'Height (${UnitConverter.heightUnitLabel(units)})',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _weight,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: InputDecoration(
                          labelText:
                              'Weight (${UnitConverter.weightUnitLabel(units)})',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _notes,
                  decoration: const InputDecoration(
                    labelText: 'Notes (optional)',
                  ),
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () => _log(units),
                  child: const Text('Log measurement'),
                ),
              ],
            ),
          ),
          if (entries.length >= 2) ...[
            const SizedBox(height: 16),
            AppCard(
              title: 'Growth Chart',
              leading: const Icon(Icons.show_chart),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Height (${UnitConverter.heightUnitLabel(units)})',
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: theme.colorScheme.outline)),
                  const SizedBox(height: 8),
                  GrowthTrendChart(
                    points: [
                      for (final e in chrono)
                        if (e.heightCm != null)
                          TrendPoint(e.measuredAt,
                              UnitConverter.heightFromCm(e.heightCm!, units)),
                    ],
                    color: context.clinical.chartLine,
                    unitLabel: UnitConverter.heightUnitLabel(units),
                  ),
                  const SizedBox(height: 20),
                  Text('Weight (${UnitConverter.weightUnitLabel(units)})',
                      style: theme.textTheme.labelMedium
                          ?.copyWith(color: theme.colorScheme.outline)),
                  const SizedBox(height: 8),
                  GrowthTrendChart(
                    points: [
                      for (final e in chrono)
                        if (e.weightKg != null)
                          TrendPoint(e.measuredAt,
                              UnitConverter.weightFromKg(e.weightKg!, units)),
                    ],
                    color: context.clinical.chartLineSecondary,
                    unitLabel: UnitConverter.weightUnitLabel(units),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          AppCard(
            title: 'Growth History',
            leading: const Icon(Icons.trending_up),
            child: entries.isEmpty
                ? const EmptyState(
                    message: 'No measurements yet.',
                    icon: Icons.show_chart,
                  )
                : Column(
                    children: [
                      for (final e in entries)
                        _GrowthTile(
                          dateLabel: df.format(e.measuredAt),
                          heightCm: e.heightCm,
                          weightKg: e.weightKg,
                          units: units,
                          velocity: velocityByDate[e.measuredAt],
                          notes: e.notes,
                          onDelete: () async {
                            final repo = ref.read(growthRepositoryProvider);
                            await repo.delete(e.id);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                content: const Text('Measurement deleted'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () => repo.restore(e),
                                ),
                              ));
                          },
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _GrowthTile extends StatelessWidget {
  const _GrowthTile({
    required this.dateLabel,
    required this.heightCm,
    required this.weightKg,
    required this.units,
    required this.velocity,
    required this.notes,
    required this.onDelete,
  });

  final String dateLabel;
  final double? heightCm;
  final double? weightKg;
  final UnitSystem units;
  final GrowthVelocity? velocity;
  final String? notes;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bmi = GrowthMath.bmi(heightCm: heightCm, weightKg: weightKg);
    final parts = <String>[
      if (heightCm != null) UnitConverter.formatHeight(heightCm!, units),
      if (weightKg != null) UnitConverter.formatWeight(weightKg!, units),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dateLabel,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600)),
                Text(parts.join('   ·   '), style: theme.textTheme.bodyMedium),
                Wrap(
                  spacing: 10,
                  children: [
                    if (bmi != null)
                      Text('BMI ${bmi.toStringAsFixed(1)}',
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: theme.colorScheme.outline)),
                    if (velocity != null)
                      Text('${velocity!.formatted(units)} growth',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: velocity!.isPositive
                                ? context.clinical.good
                                : theme.colorScheme.error,
                            fontWeight: FontWeight.w600,
                          )),
                  ],
                ),
                if ((notes ?? '').isNotEmpty)
                  Text(notes!,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.outline)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
