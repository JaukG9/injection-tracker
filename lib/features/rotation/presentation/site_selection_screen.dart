import 'package:flutter/material.dart';

import '../../../data/local/database/seed_sites.dart';
import '../../../domain/models/enums.dart';

/// Opens the site chooser and returns the selected site keys, or null if
/// cancelled. [initial] is the currently allowed set.
Future<Set<String>?> chooseInjectionSites(
  BuildContext context,
  Set<String> initial,
) {
  return Navigator.of(context).push<Set<String>>(
    MaterialPageRoute(builder: (_) => _SiteSelectionScreen(initial: initial)),
  );
}

const _regionOrder = [
  BodyRegion.arm,
  BodyRegion.stomach,
  BodyRegion.thigh,
  BodyRegion.buttock,
];

String _regionTitle(BodyRegion r) => switch (r) {
      BodyRegion.arm => 'Upper arms',
      BodyRegion.stomach => 'Abdomen',
      BodyRegion.thigh => 'Thighs',
      BodyRegion.buttock => 'Buttocks',
      BodyRegion.other => 'Other',
    };

class _SiteSelectionScreen extends StatefulWidget {
  const _SiteSelectionScreen({required this.initial});

  final Set<String> initial;

  @override
  State<_SiteSelectionScreen> createState() => _SiteSelectionScreenState();
}

class _SiteSelectionScreenState extends State<_SiteSelectionScreen> {
  late final Set<String> _selected = {...widget.initial};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Group the canonical sites by region, in a friendly order.
    final byRegion = <BodyRegion, List<SeedSite>>{};
    for (final s in kSeedSites) {
      byRegion.putIfAbsent(s.region, () => []).add(s);
    }
    final regions = _regionOrder.where(byRegion.containsKey).toList();
    final canSave = _selected.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Injection sites'),
        actions: [
          TextButton(
            onPressed:
                canSave ? () => Navigator.of(context).pop(_selected) : null,
            child: const Text('Done'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Text(
              'Pick the spots you can use for this medication. When you log an '
              'injection, only these will be tappable.',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: () =>
                      setState(() => _selected.addAll(allSiteKeys)),
                  child: const Text('Select all'),
                ),
                TextButton(
                  onPressed: () => setState(_selected.clear),
                  child: const Text('Clear'),
                ),
              ],
            ),
          ),
          for (final region in regions) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: Text(
                _regionTitle(region).toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            ...byRegion[region]!.map(
              (s) => CheckboxListTile(
                title: Text(s.name),
                value: _selected.contains(s.key),
                onChanged: (on) => setState(() {
                  if (on ?? false) {
                    _selected.add(s.key);
                  } else {
                    _selected.remove(s.key);
                  }
                }),
              ),
            ),
          ],
          if (!canSave)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                'Choose at least one site.',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.error),
              ),
            ),
        ],
      ),
    );
  }
}
