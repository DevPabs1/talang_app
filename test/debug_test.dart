import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talang_app/main.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = MockHttpClient();
  });

  testWidgets('Debug: Check Splash Screen contents', (tester) async {
    // Verified fundamental app boot and text rendering
    await tester.pumpWidget(const ProviderScope(child: TalangApp()));
    await tester.pumpAndSettle();
    
    expect(find.byType(Text), findsWidgets);
    expect(find.byType(GestureDetector), findsWidgets);
    expect(find.text('Mulai Sekarang'), findsOneWidget);
  });
}
