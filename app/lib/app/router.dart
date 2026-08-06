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
            pageBuilder: (context, state) =>
                _tabPage(state, const DashboardScreen()),
          ),
          GoRoute(
            path: '/calendar',
            pageBuilder: (context, state) =>
                _tabPage(state, const CalendarScreen()),
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) =>
                _tabPage(state, const HistoryScreen()),
          ),
          GoRoute(
            path: '/growth',
            pageBuilder: (context, state) =>
                _tabPage(state, const GrowthScreen()),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) =>
                _tabPage(state, const SettingsScreen()),
          ),
        ],
      ),
    ],
  );
});

/// Page wrapper for the bottom-nav tabs: a horizontal shared-axis transition
/// whose direction follows [tabNavReverse] (see [HomeShell]), so moving to a
/// tab on the right slides forward and moving left slides back.
CustomTransitionPage<void> _tabPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 260),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    transitionsBuilder: _sharedAxisHorizontal,
    child: child,
  );
}

/// Material shared-axis (x) transition. Each page drives its own entrance with
/// [animation] and its exit (while being covered) with [secondaryAnimation],
/// so no screen is rebuilt off-screen. Slide direction flips with
/// [tabNavReverse]: forward = new page in from the right, old page out to the
/// left; reverse = the mirror image.
Widget _sharedAxisHorizontal(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const shift = 0.12; // fraction of page width to slide
  final dir = tabNavReverse.value ? -1.0 : 1.0;

  final enterSlide = Tween<Offset>(
    begin: Offset(dir * shift, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

  final exitSlide = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(-dir * shift, 0),
  ).animate(
    CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInCubic),
  );

  return FadeTransition(
    // Fade the outgoing page out as it gets covered.
    opacity: ReverseAnimation(
      CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeIn),
    ),
    child: SlideTransition(
      position: exitSlide,
      child: FadeTransition(
        // Fade the incoming page in.
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: SlideTransition(position: enterSlide, child: child),
      ),
    ),
  );
}
