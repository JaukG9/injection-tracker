import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../app/theme/clinical_colors.dart';
import '../../../core/widgets/body_map.dart';
import '../../../domain/models/enums.dart';

/// Renders the front + back interactive body maps for the active profile,
/// coloured by site recency. Reused by the dashboard and the log flow.
class RotationMapSection extends ConsumerWidget {
  const RotationMapSection({
    super.key,
    required this.onTapSite,
    this.selectedKey,
  });

  final ValueChanged<String> onTapSite;
  final String? selectedKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clinical = context.clinical;
    final sites = ref.watch(sitesProvider).value ?? const [];
    final recencies = ref.watch(siteRecenciesProvider);
    final statusByKey = {for (final r in recencies) r.site.key: r};

    List<BodyMapSite> mapFor(BodyView view) => sites
        .where((s) => BodyView.fromName(s.bodyView) == view)
        .map((s) {
      final rec = statusByKey[s.siteKey];
      return BodyMapSite(
        key: s.siteKey,
        cx: s.cx,
        cy: s.cy,
        rx: s.rx,
        ry: s.ry,
        color: clinical.forStatus(rec?.status ?? SiteStatus.good),
        shortLabel: shortLabelForRegion(BodyRegion.fromName(s.region)),
        semanticLabel: s.name,
        selected: s.siteKey == selectedKey,
        enabled: s.isEnabled,
      );
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Size each map so the two always fit side by side (with a gap),
        // never exceeding the original 150px.
        const gap = 24.0;
        final mapWidth =
            (((constraints.maxWidth - gap) / 2).clamp(80.0, 150.0)).toDouble();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _labelled(
              context,
              'FRONT',
              BodyMap(
                sites: mapFor(BodyView.front),
                onTapSite: onTapSite,
                width: mapWidth,
              ),
            ),
            _labelled(
              context,
              'BACK',
              BodyMap(
                sites: mapFor(BodyView.back),
                onTapSite: onTapSite,
                width: mapWidth,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _labelled(BuildContext context, String label, Widget child) {
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
