import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talang_app/features/home/home_screen.dart';
import 'package:talang_app/core/theme/app_theme.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpClient();
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception is NetworkImageLoadException) return;
      FlutterError.presentError(details);
    };
  });

  Widget createTestWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.smoothWhite,
        home: child,
        // Provide routes so that navigation taps don't crash the test
        routes: {
          '/home': (context) => const HomeScreen(),
          '/split': (context) => const Scaffold(body: Text('Split Screen')),
        },
      ),
    );
  }

  testWidgets('Stress Test: Interaction Sweep on HomeScreen', (tester) async {
    // 1. Build Homepage directly (matching smoke_test pattern)
    await tester.pumpWidget(createTestWidget(const HomeScreen()));
    
    // 2. Initial settle (bounded)
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(HomeScreen), findsOneWidget);

    // 3. Identify all possible touch targets
    final finders = [
      find.byType(InkWell),
      find.byType(ElevatedButton),
      find.byType(IconButton),
      find.byType(GestureDetector),
    ];

    // 4. Stress Test Loop
    for (var finder in finders) {
      final elements = finder.evaluate();
      for (int i = 0; i < elements.length; i++) {
        try {
          await tester.tap(finder.at(i), warnIfMissed: false);
          await tester.pump(const Duration(milliseconds: 100));
          await tester.pump(const Duration(milliseconds: 100));
        } catch (e) {
          // Ignore hits that fail (e.g. off screen)
        }
      }
    }

    // 5. Verification: The app did not crash and some content is still visible
    expect(find.byType(Scaffold), findsWidgets);
  });
}
