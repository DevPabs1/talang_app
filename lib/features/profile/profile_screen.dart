import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Figma Teal Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 80, bottom: 40, left: 24, right: 24),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                   const CircleAvatar(
                     radius: 50,
                     backgroundColor: Colors.white,
                     child: Text('BS', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
                   ),
                   const SizedBox(height: 16),
                   const Text(
                     'Budi Santoso',
                     style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                   ),
                   Text(
                     '@budi.santoso',
                     style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                   ),
                ],
              ),
            ),
            
            // Stats Dashboard
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(label: 'Transaksi', value: '142'),
                    _StatItem(label: 'Dikirim', value: 'Rp 4.2jt'),
                    _StatItem(label: 'Teman', value: '28'),
                  ],
                ),
              ),
            ),
            
            // Menu Items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const _ProfileMenuTile(icon: Icons.notifications_none, label: 'Notifikasi'),
                  const _ProfileMenuTile(icon: Icons.lock_outline, label: 'Keamanan & PIN'),
                  const _ProfileMenuTile(icon: Icons.account_balance_outlined, label: 'Rekening Bank'),
                  const _ProfileMenuTile(icon: Icons.shield_outlined, label: 'Data & Privasi (UU PDP)'),
                  const _ProfileMenuTile(icon: Icons.help_outline, label: 'Bantuan'),
                  const Divider(height: 32),
                  _ProfileMenuTile(
                    icon: Icons.logout, 
                    label: 'Keluar', 
                    isDanger: true,
                    onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.zinc500)),
      ],
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDanger;
  final VoidCallback? onTap;

  const _ProfileMenuTile({
    required this.icon, 
    required this.label, 
    this.isDanger = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDanger ? AppColors.error.withOpacity(0.1) : AppColors.zinc100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: isDanger ? AppColors.error : AppColors.zinc600, size: 20),
      ),
      title: Text(
        label, 
        style: TextStyle(
          color: isDanger ? AppColors.error : AppColors.textPrimary,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.zinc400, size: 20),
    );
  }
}
