import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:injection_tracker/app/providers.dart';
import 'package:injection_tracker/app/theme/app_theme.dart';
import 'package:injection_tracker/data/local/database/app_database.dart';
import 'package:injection_tracker/features/onboarding/presentation/onboarding_screen.dart';

/// Widget-level render/validation test for onboarding. The end-to-end data flow
/// (create profile -> seed sites -> read back) is covered deterministically by
/// the repository integration tests, which use the real database without the
/// widget-test fake-async clock that drift's streams don't advance under.
void main() {
  Widget harness(AppDatabase db) => ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const OnboardingScreen(),
        ),
      );

  testWidgets('onboarding renders its key fields and the create action',
      (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(harness(db));
    await tester.pumpAndSettle();

    expect(find.textContaining('Welcome to'), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.text('Create profile'), findsOneWidget);
    // Units segmented control and schedule dropdown are present.
    expect(find.text('in / lb'), findsOneWidget);
    expect(find.text('cm / kg'), findsOneWidget);
  });

  testWidgets('submitting with an empty name shows a validation error',
      (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(harness(db));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Create profile'));
    await tester.pump();

    expect(find.text('Enter a name'), findsOneWidget);
  });
}
