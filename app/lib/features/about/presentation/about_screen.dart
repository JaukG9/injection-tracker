import 'package:flutter/material.dart';

import '../../../app/theme/clinical_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_card.dart';
import '../../../domain/models/enums.dart';

/// Help / About: how the app works, the safety disclaimer, privacy, version.
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clinical = context.clinical;

    return Scaffold(
      appBar: AppBar(title: const Text('Help & About')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            title: 'How site rotation works',
            leading: const Icon(Icons.help_outline),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Each spot is colored by how recently you used it, so you '
                  'can keep rotating and give the skin time to recover:',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                _legendRow(context, clinical.forStatus(SiteStatus.good),
                    'Good to use. Never used, or 6 or more days ago.'),
                _legendRow(context, clinical.forStatus(SiteStatus.recent),
                    'Used recently, about 3 to 5 days ago.'),
                _legendRow(context, clinical.forStatus(SiteStatus.veryRecent),
                    'Used very recently, within the last couple of days.'),
                const SizedBox(height: 8),
                Text(
                  'The home screen points you to whichever spot has rested the '
                  'longest. You can always tap a different one to log there.',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: 'Privacy',
            leading: const Icon(Icons.lock_outline),
            child: Text(
              'Everything you enter stays on this device. It never gets sent to '
              'a server or shared with anyone. Just remember to export a backup '
              'now and then, and before you switch phones.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            title: 'Important',
            leading: const Icon(Icons.info_outline),
            child: Text(
              AppConstants.supportDisclaimer,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              '${AppConstants.appName} · v${AppConstants.appVersion}',
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.outline),
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendRow(BuildContext context, Color color, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
