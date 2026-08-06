import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../app/providers.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/status_widgets.dart';
import '../../../data/local/database/app_database.dart';
import '../../../domain/models/enums.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final injections = ref.watch(injectionsProvider).value ?? const [];
    final sites = ref.watch(sitesProvider).value ?? const [];
    final sitesById = {for (final s in sites) s.id: s};
    final df = DateFormat('MMM d, yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('Injection History')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'Injections',
            leading: const Icon(Icons.history),
            child: injections.isEmpty
                ? const EmptyState(
                    message: 'No injections logged yet.',
                    icon: Icons.inbox_outlined,
                  )
                : Column(
                    children: [
                      for (final inj in injections)
                        _InjectionTile(
                          injection: inj,
                          site: sitesById[inj.siteId],
                          dateLabel: df.format(inj.injectedAt),
                          onDelete: () async {
                            final repo = ref.read(injectionRepositoryProvider);
                            await repo.delete(inj.id);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                content: const Text('Injection deleted'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () => repo.restore(inj),
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

class _InjectionTile extends StatelessWidget {
  const _InjectionTile({
    required this.injection,
    required this.site,
    required this.dateLabel,
    required this.onDelete,
  });

  final InjectionRow injection;
  final InjectionSiteRow? site;
  final String dateLabel;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final region = BodyRegion.fromName(site?.region);
    final dose = injection.doseValue == null
        ? ''
        : '${_fmt(injection.doseValue!)} ${DoseUnit.fromName(injection.doseUnit).label}';

    return Dismissible(
      key: ValueKey(injection.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: theme.colorScheme.errorContainer,
        child: Icon(Icons.delete_outline, color: theme.colorScheme.onErrorContainer),
      ),
      onDismissed: (_) => onDelete(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dateLabel, style: theme.textTheme.bodyMedium),
                  if ((injection.notes ?? '').isNotEmpty)
                    Text(
                      injection.notes!,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.colorScheme.outline),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SitePill(
                  label: site?.name ?? 'Unknown',
                  region: region,
                ),
              ),
            ),
            if (dose.isNotEmpty)
              Text(dose, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  String _fmt(double v) =>
      v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}
