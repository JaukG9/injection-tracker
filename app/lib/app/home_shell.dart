import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Top-level navigation shell. Shows a bottom [NavigationBar] on phones and a
/// [NavigationRail] on wider screens (tablet/desktop), per the responsive plan.
class HomeShell extends StatelessWidget {
  const HomeShell({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    _Dest('/dashboard', Icons.home_outlined, Icons.home, 'Home'),
    _Dest('/calendar', Icons.calendar_month_outlined, Icons.calendar_month,
        'Calendar'),
    _Dest('/history', Icons.history_outlined, Icons.history, 'History'),
    _Dest('/growth', Icons.trending_up_outlined, Icons.trending_up, 'Growth'),
    _Dest('/settings', Icons.settings_outlined, Icons.settings, 'Settings'),
  ];

  int _indexFor(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final i = _destinations.indexWhere((d) => loc.startsWith(d.path));
    return i < 0 ? 0 : i;
  }

  void _onTap(BuildContext context, int i) =>
      context.go(_destinations[i].path);

  @override
  Widget build(BuildContext context) {
    final index = _indexFor(context);
    final wide = MediaQuery.sizeOf(context).width >= 600;

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (i) => _onTap(context, i),
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final d in _destinations)
                  NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => _onTap(context, i),
        destinations: [
          for (final d in _destinations)
            NavigationDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

class _Dest {
  const _Dest(this.path, this.icon, this.selectedIcon, this.label);
  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
