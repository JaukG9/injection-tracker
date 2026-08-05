import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme/clinical_colors.dart';
import '../../../core/utils/date_utils.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/profile_avatar.dart';
import '../../../core/widgets/status_widgets.dart';
import '../../../domain/models/enums.dart';
import '../../../domain/services/dose_math.dart';
import '../../../domain/services/site_rotation_service.dart';
import '../../injection/presentation/dose_dialog.dart';
import '../../injection/presentation/log_injection_screen.dart';
import '../../profiles/presentation/profile_switcher.dart';
import '../../rotation/presentation/rotation_map_section.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  void _openLog(BuildContext context, {String? siteKey}) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LogInjectionScreen(initialSiteKey: siteKey),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final profile = ref.watch(activeProfileProvider);
    final name = profile?.name ?? 'your profile';
    final allRecencies = ref.watch(siteRecenciesProvider);
    final suggestedKey = ref.watch(suggestedSiteProvider);

    // The rotation grid lists only the sites allowed for this medication.
    final siteList = ref.watch(sitesProvider).value;
    final enabledKeys = <String>{
      if (siteList != null)
        for (final s in siteList)
          if (s.isEnabled) s.siteKey,
    };
    final recencies =
        allRecencies.where((r) => enabledKeys.contains(r.site.key)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("$name's Tracker"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              tooltip: 'Switch profile',
              icon: ProfileAvatar(
                name: name,
                avatarPath: profile?.avatarPath,
                radius: 16,
              ),
              onPressed: () => showProfileSwitcher(context, ref),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            "Tonight's injection for $name",
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            'Injection site log & rotation helper',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 16),
          _SuggestionCard(recencies: recencies, suggestedKey: suggestedKey),
          const SizedBox(height: 16),
          _CurrentDoseCard(),
          const SizedBox(height: 16),
          AppCard(
            title: 'Site Rotation Overview',
            leading: const Icon(Icons.grid_view_outlined),
            child: Column(
              children: [
                RotationMapSection(
                  selectedKey: suggestedKey,
                  onTapSite: (key) => _openLog(context, siteKey: key),
                ),
                const SizedBox(height: 16),
                _RotationGrid(recencies: recencies),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => _openLog(context, siteKey: suggestedKey),
            icon: const Icon(Icons.add),
            label: const Text("Log tonight's injection"),
          ),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.recencies, required this.suggestedKey});

  final List<SiteRecency> recencies;
  final String? suggestedKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clinical = context.clinical;
    SiteRecency? suggestion;
    for (final r in recencies) {
      if (r.site.key == suggestedKey) suggestion = r;
    }

    if (suggestion == null) {
      return AppCard(
        child: Text(
          'Add sites to see a rotation suggestion.',
          style: theme.textTheme.bodyMedium,
        ),
      );
    }

    final note = suggestion.everUsed
        ? 'last used ${AppDates.agoLabel(suggestion.daysSince!)}'
        : 'never used yet';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: clinical.goodContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: clinical.good.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          StatusDot(status: suggestion.status, size: 14),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Suggested site: '),
                  TextSpan(
                    text: suggestion.site.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: clinical.good,
                    ),
                  ),
                  TextSpan(text: ' ($note).'),
                ],
              ),
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrentDoseCard extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final medication = ref.watch(activeMedicationProvider).value;
    final growth = ref.watch(growthEntriesProvider).value ?? const [];

    final doseValue = medication?.defaultDoseValue;
    final doseUnit = DoseUnit.fromName(medication?.defaultDoseUnit);

    double? latestWeight;
    for (final g in growth) {
      if (g.weightKg != null) {
        latestWeight = g.weightKg;
        break; // list is newest-first
      }
    }
    final mgPerKg = DoseMath.mgPerKg(
      doseValue: doseValue,
      unit: doseUnit,
      latestWeightKg: latestWeight,
    );

    return AppCard(
      title: 'Current Dose',
      leading: const Icon(Icons.medication_outlined),
      trailing: TextButton(
        onPressed: () => showDoseDialog(context, ref),
        child: Text(doseValue == null ? 'Set' : 'Change'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doseValue == null
                ? 'Not set'
                : '${_fmt(doseValue)} ${doseUnit.label}',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          if (mgPerKg != null) ...[
            const SizedBox(height: 2),
            Text(
              '≈ ${mgPerKg.toStringAsFixed(3)} mg/kg',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ],
          const SizedBox(height: 6),
          InkWell(
            onTap: () => showModalBottomSheet<void>(
              context: context,
              showDragHandle: true,
              builder: (_) => const DoseHistorySheet(),
            ),
            child: Text(
              'View dose history',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}

class _RotationGrid extends StatelessWidget {
  const _RotationGrid({required this.recencies});

  final List<SiteRecency> recencies;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (recencies.isEmpty) {
      return const EmptyState(message: 'No sites configured yet.');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 420 ? 3 : 2;
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.2,
          children: [
            for (final r in recencies)
              Semantics(
                label: '${r.site.name}, '
                    '${r.everUsed ? 'last used ${AppDates.agoLabel(r.daysSince!)}' : 'never used'}, '
                    '${switch (r.status) {
                      SiteStatus.good => 'good to use',
                      SiteStatus.recent => 'used recently',
                      SiteStatus.veryRecent => 'used very recently',
                    }}',
                excludeSemantics: true,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                  ),
                  child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 4,
                      color: context.clinical.forStatus(r.status),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                StatusDot(status: r.status, size: 10),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    r.site.name,
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              r.everUsed
                                  ? 'Last used ${AppDates.agoLabel(r.daysSince!)}'
                                  : 'Never used',
                              style: theme.textTheme.bodySmall
                                  ?.copyWith(color: theme.colorScheme.outline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ),
          ],
        );
      },
    );
  }
}
