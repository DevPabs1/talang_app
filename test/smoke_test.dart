import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talang_app/main.dart';
import 'package:talang_app/core/theme/app_theme.dart';
import 'package:talang_app/features/splash/splash_screen.dart';
import 'package:talang_app/features/home/home_screen.dart';
import 'package:talang_app/features/ekyc/ekyc_screen.dart';
import 'package:talang_app/features/groups/groups_screen.dart';
import 'package:talang_app/features/split/assign_items_screen.dart';
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
      ),
    );
  }

  testWidgets('Smoke Test: App boots and renders SlashScreen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TalangApp()));
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('Talang'), findsOneWidget);
  });

  testWidgets('Smoke Test: HomeScreen renders correctly', (tester) async {
    await tester.pumpWidget(createTestWidget(const HomeScreen()));
    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('Layanan Utama'), findsOneWidget);
  });

  testWidgets('Smoke Test: GroupsScreen renders correctly', (tester) async {
    await tester.pumpWidget(createTestWidget(const GroupsScreen()));
    expect(find.text('Saldo Kas Bersama'), findsOneWidget);
  });

  testWidgets('Smoke Test: EkycScreen renders correctly', (tester) async {
    await tester.pumpWidget(createTestWidget(const EkycScreen()));
    expect(find.text('Lengkapi Identitas Kamu'), findsOneWidget);
  });

  testWidgets('Smoke Test: AssignItemsScreen renders correctly', (tester) async {
    await tester.pumpWidget(createTestWidget(const AssignItemsScreen()));
    expect(find.text('Bagi Tagihan'), findsOneWidget);
  });
}
