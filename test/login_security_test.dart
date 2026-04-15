import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talang_app/main.dart';
import 'package:talang_app/features/auth/login_screen.dart';

void main() {
  testWidgets('Login button should not navigate if fields are empty', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TalangApp(initialRoute: '/login'),
      ),
    );

    expect(find.byType(LoginScreen), findsOneWidget);

    // Tap Continue button without filling anything
    final loginButton = find.widgetWithText(ElevatedButton, 'Continue');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Verify we are still on LoginScreen and see validation errors
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('Please enter your phone number'), findsOneWidget);
  });

  testWidgets('Login button should navigate if fields are filled', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TalangApp(initialRoute: '/login'),
      ),
    );

    expect(find.byType(LoginScreen), findsOneWidget);

    // Fill the fields. Login screen only has 1 form field now.
    await tester.enterText(find.byType(TextFormField).at(0), '08123456789');
    await tester.pump();

    // Tap Continue button
    final loginButton = find.widgetWithText(ElevatedButton, 'Continue');
    await tester.tap(loginButton);
    await tester.pumpAndSettle();

    // Verify we navigated to the next screen (EkycScreen usually contains 'Verify Your Identity')
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.text('Verifikasi Identitas'), findsOneWidget);
  });
}
