import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/calendar/presentation/calendar_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/growth/presentation/growth_screen.dart';
import '../features/history/presentation/history_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/security/presentation/lock_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import 'home_shell.dart';
import 'providers.dart';

/// Bridges Riverpod state into a [Listenable] so GoRouter re-evaluates its
/// redirect whenever onboarding/auth state changes.
class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref
      ..listen(onboardingCompleteProvider, (_, _) => notifyListeners())
      ..listen(appLockEnabledProvider, (_, _) => notifyListeners())
      ..listen(authenticatedProvider, (_, _) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final onboardingDone = _ref.read(onboardingCompleteProvider);
    final lockEnabled = _ref.read(appLockEnabledProvider);
    final authed = _ref.read(authenticatedProvider);
    final loc = state.matchedLocation;

    if (!onboardingDone) {
      return loc == '/onboarding' ? null : '/onboarding';
    }
    if (loc == '/onboarding') return '/dashboard';

    // App lock gate.
    if (lockEnabled && !authed) {
      return loc == '/lock' ? null : '/lock';
    }
    if (loc == '/lock') return '/dashboard';
    return null;
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);

  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/lock',
        builder: (context, state) => const LockScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => HomeShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/calendar',
            builder: (context, state) => const CalendarScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/growth',
            builder: (context, state) => const GrowthScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
