import 'package:flutter/material.dart';

import '../../app/theme/clinical_colors.dart';
import '../../domain/models/enums.dart';

/// A small coloured dot indicating site recency status. Includes a [Semantics]
/// label so status is not conveyed by colour alone.
class StatusDot extends StatelessWidget {
  const StatusDot({super.key, required this.status, this.size = 12});

  final SiteStatus status;
  final double size;

  String get _label => switch (status) {
        SiteStatus.good => 'Good to use',
        SiteStatus.recent => 'Used recently',
        SiteStatus.veryRecent => 'Used very recently',
      };

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: _label,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: context.clinical.forStatus(status),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// A rounded pill showing a site or tag, tinted by body region.
class SitePill extends StatelessWidget {
  const SitePill({super.key, required this.label, required this.region});

  final String label;
  final BodyRegion region;

  @override
  Widget build(BuildContext context) {
    final tint = context.clinical.forRegion(region);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tint,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// Empty-state placeholder used when a list has no data.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.message, this.icon});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          if (icon != null) ...[
            Icon(icon, color: theme.colorScheme.outline, size: 32),
            const SizedBox(height: 8),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.outline),
          ),
        ],
      ),
    );
  }
}
