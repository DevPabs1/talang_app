import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:talang_app/features/transfer/transfer_success_screen.dart';
import 'package:talang_app/features/ekyc/liveness_check_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('UI/UX Integration Tests', () {
    testWidgets('Liveness Check Screen UI matches Stitch design', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LivenessCheckScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify specific elements from the Stitch design are present
      expect(find.text('Identity Verification'), findsOneWidget);
      expect(find.text('Face Detected'), findsOneWidget);
      expect(find.text('Verify Identity'), findsOneWidget);
      expect(find.text('END-TO-END ENCRYPTED VERIFICATION'), findsOneWidget);
    });

    testWidgets('Transfer Success Screen UI matches Stitch design', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: TransferSuccessScreen(
              amount: 142.50,
              receiver: 'La Favela',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify specific elements from the Stitch design are present
      expect(find.text('\$142.50'), findsOneWidget);
      expect(find.text('Paid La Favela'), findsOneWidget);
      expect(find.text('SUCCESS'), findsOneWidget);
      expect(find.text('DATE & TIME'), findsOneWidget);
      expect(find.text('PAYMENT METHOD'), findsOneWidget);
      expect(find.text('TRANSACTION ID'), findsOneWidget);
      expect(find.text('Add Comment'), findsOneWidget);
      expect(find.text('Share Receipt'), findsOneWidget);
    });
  });
}
