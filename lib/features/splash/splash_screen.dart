import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                // Stitch Center Identity
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(48), // Deep Sync: 48px rounding
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 40,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.account_balance_wallet, size: 84, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 56),
                Text(
                  'Talang',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 56,
                    fontWeight: FontWeight.w800,
                    color: AppColors.deepZinc,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Solusi Bayar Bareng yang Halus',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    color: AppColors.brandGray,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 80),
                BouncyButton(
                  onTap: () => Navigator.pushNamed(context, '/register'),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: AppColors.primary,
                    ),
                    child: const Text(
                      'Mulai Sekarang',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  child: const Text(
                    'Sudah punya akun? Masuk',
                    style: TextStyle(color: AppColors.brandGray, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
