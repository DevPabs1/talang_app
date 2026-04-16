import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';

class EkycScreen extends StatefulWidget {
  const EkycScreen({super.key});

  @override
  State<EkycScreen> createState() => _EkycScreenState();
}

class _EkycScreenState extends State<EkycScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Verifikasi Identitas'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.deepZinc,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                'Lengkapi Identitas Kamu',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Upgrade ke Talang Premium untuk menikmati fitur Split Bill AI dan limit lebih besar.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.brandGray),
              ),
              const SizedBox(height: 40),
              
              // Stitch-style KTP Illustration
              Container(
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 160,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.primary, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.1),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.badge_outlined, size: 56, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Posisikan KTP di Dalam Kotak',
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.deepZinc),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pastikan KTP berada di dalam kotak dan terbaca jelas.',
                      style: TextStyle(fontSize: 12, color: AppColors.brandGray),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              const _FeatureRow(icon: Icons.verified_user_outlined, text: 'Data aman terenkripsi mengikuti regulasi'),
              const SizedBox(height: 16),
              const _FeatureRow(icon: Icons.flash_on_outlined, text: 'Verifikasi instan kurang dari 2 menit'),
              
              const SizedBox(height: 40),
              BouncyButton(
                onTap: () => Navigator.pushNamed(context, '/ktp_scan'),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.primary,
                  ),
                  child: const Text(
                    'Ambil Foto KTP',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  shape: const StadiumBorder(),
                  side: const BorderSide(color: AppColors.border),
                  foregroundColor: AppColors.brandGray,
                ),
                child: const Text('Nanti Saja'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: AppColors.deepZinc, fontWeight: FontWeight.w500))),
      ],
    );
  }
}
