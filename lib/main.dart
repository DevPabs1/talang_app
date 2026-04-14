import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/register_screen.dart';
import 'features/ekyc/ekyc_screen.dart';
import 'features/ekyc/ktp_scan_screen.dart';
import 'features/ekyc/liveness_check_screen.dart';
import 'features/home/home_screen.dart';
import 'features/transfer/transfer_screen.dart';
import 'features/transfer/transfer_success_screen.dart';
import 'features/history/history_screen.dart';
import 'features/split/split_bill_screen.dart';
import 'features/split/scan_receipt_screen.dart';
import 'features/split/receipt_items_screen.dart';
import 'features/split/assign_items_screen.dart';
import 'features/auth/privacy_consent_screen.dart';
import 'features/groups/groups_screen.dart';
import 'features/groups/create_group_screen.dart';
import 'features/feed/feed_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TalangApp(),
    ),
  );
}

class TalangApp extends StatelessWidget {
  final String initialRoute;
  const TalangApp({super.key, this.initialRoute = '/'});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talang',
      theme: AppTheme.smoothWhite,
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/ekyc': (context) => const EkycScreen(),
        '/ktp_scan': (context) => const KtpScanScreen(),
        '/liveness': (context) => const LivenessCheckScreen(),
        '/privacy': (context) => const PrivacyConsentScreen(),
        '/home': (context) => const HomeScreen(),
        '/transfer': (context) => const TransferScreen(),
        '/success': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return TransferSuccessScreen(
            amount: args['amount'],
            receiver: args['receiver'],
          );
        },
        '/history': (context) => const HistoryScreen(),
        '/split': (context) => const SplitBillScreen(),
        '/scan_receipt': (context) => const ScanReceiptScreen(),
        '/receipt_items': (context) => const ReceiptItemsScreen(),
        '/groups': (context) => const GroupsScreen(),
        '/create_group': (context) => const CreateGroupScreen(),
        '/assign_items': (context) => const AssignItemsScreen(),
        '/feed': (context) => const FeedScreen(),
      },
    );
  }
}
