import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  // Initialise notifications + timezones before the first frame.
  await container.read(notificationServiceProvider).init();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const InjectionTrackerApp(),
    ),
  );
}
