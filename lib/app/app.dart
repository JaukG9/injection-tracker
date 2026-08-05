import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/app_constants.dart';
import 'providers.dart';
import 'router.dart';
import 'theme/app_theme.dart';

class InjectionTrackerApp extends ConsumerWidget {
  const InjectionTrackerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    // A profile may carry its own accent seed.
    final seed = ref.watch(activeProfileProvider)?.colorSeed;
    final seedColor = seed == null ? AppTheme.defaultSeed : Color(seed);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(seedColor),
      darkTheme: AppTheme.dark(seedColor),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
