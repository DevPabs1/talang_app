import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talang_app/main.dart';
import 'package:talang_app/features/splash/splash_screen.dart';
import 'package:talang_app/features/auth/register_screen.dart';
import 'package:talang_app/features/ekyc/ekyc_screen.dart';
import 'package:talang_app/features/ekyc/ktp_scan_screen.dart';
import 'package:talang_app/features/ekyc/liveness_check_screen.dart';
import 'package:talang_app/features/auth/privacy_consent_screen.dart';
import 'package:talang_app/features/home/home_screen.dart';
import 'package:talang_app/core/widgets/bouncy_button.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpClient();
    FlutterError.onError = (FlutterErrorDetails details) {
      if (details.exception is NetworkImageLoadException) return;
      FlutterError.presentError(details);
    };
  });

  testWidgets('Navigation Test: Full Onboarding Flow', (tester) async {
    // 1. Boot from Splash
    await tester.pumpWidget(
      const ProviderScope(
        child: TalangApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SplashScreen), findsOneWidget);

    // 2. Trigger "Mulai Sekarang" -> Register
    final startButton = find.byType(BouncyButton).first;
    tester.widget<BouncyButton>(startButton).onTap?.call();
    await tester.pumpAndSettle();
    expect(find.byType(RegisterScreen), findsOneWidget);

    // 3. Fill the registration form
    await tester.enterText(find.byType(TextFormField).at(0), 'Budi Santoso');
    await tester.enterText(find.byType(TextFormField).at(1), '8123456789');
    await tester.pump();

    // 4. Trigger "Daftar Sekarang" -> EKYC Gateway
    final registerButton = find.byType(ElevatedButton).at(0);
    await tester.tap(registerButton);
    await tester.pumpAndSettle();
    expect(find.byType(EkycScreen), findsOneWidget);

    // 5. Trigger "Ambil Foto KTP" -> KTP Scan Screen
    final kycButton = find.byType(BouncyButton).first;
    tester.widget<BouncyButton>(kycButton).onTap?.call();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(KtpScanScreen), findsOneWidget);

    // 6. Trigger "Capture KTP" -> Liveness Check
    final captureButton = find.byType(BouncyButton).first;
    tester.widget<BouncyButton>(captureButton).onTap?.call();
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(LivenessCheckScreen), findsOneWidget);
    
    // 7. Wait for Liveness Animation -> Privacy Consent
    // Liveness completes after 4s simulation
    await tester.pump(const Duration(seconds: 6));
    await tester.pumpAndSettle();
    expect(find.byType(PrivacyConsentScreen), findsOneWidget);

    // 8. Trigger "Selesaikan Pendaftaran" -> Home
    final finishButton = find.byType(BouncyButton).first;
    await tester.ensureVisible(finishButton);
    tester.widget<BouncyButton>(finishButton).onTap?.call();
    
    // Final settle with Shimmer handling
    try {
      await tester.pumpAndSettle(const Duration(seconds: 1));
    } catch (e) {
      // Ignore settle timeout
    }
    
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
