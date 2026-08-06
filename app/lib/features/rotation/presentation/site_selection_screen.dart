import 'package:flutter/material.dart';

import '../../../core/widgets/body_map.dart';
import '../../../data/local/database/seed_sites.dart';
import '../../../domain/models/enums.dart';

/// Opens the site chooser and returns the selected site keys, or null if
/// cancelled. [initial] is the currently allowed set (empty for a fresh pick,
/// so the chooser starts with everything unselected).
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

class _SiteSelectionScreenState extends State<_SiteSelectionScreen>
    with SingleTickerProviderStateMixin {
  late final Set<String> _selected = {...widget.initial};
  late final TabController _tab = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _toggle(String key) => setState(() {
        if (!_selected.add(key)) _selected.remove(key);
      });

  @override
  Widget build(BuildContext context) {
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
        bottom: TabBar(
          controller: _tab,
          tabs: const [
            Tab(icon: Icon(Icons.checklist_rtl), text: 'List'),
            Tab(icon: Icon(Icons.accessibility_new), text: 'Body map'),
          ],
        ),
      ),
      body: Column(
        children: [
          _Header(
            selectedCount: _selected.length,
            total: allSiteKeys.length,
            onSelectAll: () => setState(() => _selected.addAll(allSiteKeys)),
            onClear: () => setState(_selected.clear),
          ),
          const Divider(height: 1),
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _ListTab(selected: _selected, onToggle: _toggle),
                _BodyTab(selected: _selected, onToggle: _toggle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Shared header: intro line, select-all / clear, live count, and the
/// "pick at least one" reminder while nothing is selected.
class _Header extends StatelessWidget {
  const _Header({
    required this.selectedCount,
    required this.total,
    required this.onSelectAll,
    required this.onClear,
  });

  final int selectedCount;
  final int total;
  final VoidCallback onSelectAll;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final none = selectedCount == 0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pick the spots you can use for this medication. Only these will '
            'be tappable when you log an injection.',
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.outline),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                none ? 'Choose at least one site' : '$selectedCount of $total selected',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: none
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
              ),
              const Spacer(),
              TextButton(onPressed: onSelectAll, child: const Text('Select all')),
              TextButton(onPressed: onClear, child: const Text('Clear')),
            ],
          ),
        ],
      ),
    );
  }
}

/// Text list of sites grouped by body region, with checkboxes.
class _ListTab extends StatelessWidget {
  const _ListTab({required this.selected, required this.onToggle});

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final byRegion = <BodyRegion, List<SeedSite>>{};
    for (final s in kSeedSites) {
      byRegion.putIfAbsent(s.region, () => []).add(s);
    }
    final regions = _regionOrder.where(byRegion.containsKey).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 24),
      children: [
        for (final region in regions) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 4),
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
              value: selected.contains(s.key),
              onChanged: (_) => onToggle(s.key),
            ),
          ),
        ],
      ],
    );
  }
}

/// Interactive body silhouettes (front + back). Tapping a spot toggles it.
class _BodyTab extends StatelessWidget {
  const _BodyTab({required this.selected, required this.onToggle});

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    List<BodyMapSite> mapFor(BodyView view) => kSeedSites
        .where((s) => s.view == view)
        .map((s) {
      final on = selected.contains(s.key);
      return BodyMapSite(
        key: s.key,
        cx: s.cx,
        cy: s.cy,
        rx: s.rx,
        ry: s.ry,
        color: on
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withValues(alpha: 0.22),
        shortLabel: shortLabelForRegion(s.region),
        semanticLabel: '${s.name}, ${on ? 'selected' : 'not selected'}',
        selected: on,
      );
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        Text(
          'Tap a spot to select or deselect it.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.outline),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 24.0;
            final mapWidth =
                (((constraints.maxWidth - gap) / 2).clamp(90.0, 160.0))
                    .toDouble();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MapColumn(
                  label: 'FRONT',
                  child: BodyMap(
                    sites: mapFor(BodyView.front),
                    width: mapWidth,
                    onTapSite: onToggle,
                  ),
                ),
                _MapColumn(
                  label: 'BACK',
                  child: BodyMap(
                    sites: mapFor(BodyView.back),
                    width: mapWidth,
                    onTapSite: onToggle,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
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
