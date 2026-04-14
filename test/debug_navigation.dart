import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talang_app/main.dart';
import 'package:talang_app/features/auth/privacy_consent_screen.dart';
import 'package:talang_app/features/home/home_screen.dart';
import 'package:talang_app/core/widgets/bouncy_button.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpClient();
  });

  testWidgets('Debug: Privacy -> Home Transition', (tester) async {
    // Verified onboarding gateway transition
    await tester.pumpWidget(
      const ProviderScope(
        child: TalangApp(initialRoute: '/privacy'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(PrivacyConsentScreen), findsOneWidget);
    
    final button = find.byType(BouncyButton).first;
    final bWidget = tester.widget<BouncyButton>(button);
    
    // Explicit null-safe execution
    final tapAction = bWidget.onTap;
    if (tapAction != null) {
      tapAction();
    }
    
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    
    final bool homeVisible = find.byType(HomeScreen).evaluate().isNotEmpty;
    expect(homeVisible, isTrue);
  });
}
