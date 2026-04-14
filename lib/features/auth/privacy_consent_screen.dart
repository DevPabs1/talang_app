import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';

class PrivacyConsentScreen extends StatefulWidget {
  const PrivacyConsentScreen({super.key});

  @override
  State<PrivacyConsentScreen> createState() => _PrivacyConsentScreenState();
}

class _PrivacyConsentScreenState extends State<PrivacyConsentScreen> {
  String _selectedVisibility = 'Friends';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Privasi & Keamanan'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.deepZinc,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Hampir Selesai!',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28),
              ),
              const SizedBox(height: 12),
              const Text(
                'Sesuai dengan UU PDP (Perlindungan Data Pribadi), pilih siapa yang dapat melihat aktivitas finansial Anda.',
                style: TextStyle(color: AppColors.brandGray, height: 1.5),
              ),
              const SizedBox(height: 32),
              _VisibilityOption(
                title: 'Hanya Teman',
                subtitle: 'Hanya teman di daftar kontak Anda yang dapat melihat aktivitas.',
                icon: Icons.group_rounded,
                isSelected: _selectedVisibility == 'Friends',
                onTap: () => setState(() => _selectedVisibility = 'Friends'),
              ),
              const SizedBox(height: 16),
              _VisibilityOption(
                title: 'Privat',
                subtitle: 'Hanya Anda yang dapat melihat aktivitas finansial Anda.',
                icon: Icons.lock_rounded,
                isSelected: _selectedVisibility == 'Private',
                onTap: () => setState(() => _selectedVisibility = 'Private'),
              ),
              const SizedBox(height: 16),
              _VisibilityOption(
                title: 'Publik (Sosial)',
                subtitle: 'Semua orang dapat melihat aktivitas Anda untuk transparansi komunitas.',
                icon: Icons.public_rounded,
                isSelected: _selectedVisibility == 'Public',
                onTap: () => setState(() => _selectedVisibility = 'Public'),
              ),
              const SizedBox(height: 48), // Replaced Spacer
              Text(
                'Dengan melanjutkan, Anda menyetujui Syarat & Ketentuan serta Kebijakan Privasi Talang.',
                style: TextStyle(fontSize: 11, color: AppColors.brandGray.withOpacity(0.8)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BouncyButton(
                onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.primary,
                  ),
                  child: const Text(
                    'Selesaikan Pendaftaran',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VisibilityOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _VisibilityOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32), // Deep Sync: 32px
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.04) : Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.brandGray,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: isSelected ? AppColors.primary : AppColors.deepZinc,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: AppColors.brandGray),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
