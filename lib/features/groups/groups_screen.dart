import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Grup Patungan'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.group_add_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Group Balance circular gauge (Stitch High-Fidelity)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(28),
              margin: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.nebulaGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Saldo Kas Bersama',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: CircularProgressIndicator(
                          value: 0.77,
                          strokeWidth: 14,
                          strokeCap: StrokeCap.round,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                      const Column(
                        children: [
                          Text(
                            'Rp 15.420k',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            'Target: 20.000k',
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _BalanceAction(icon: Icons.add_circle_outline, label: 'Tambah', onTap: () {}),
                      const SizedBox(width: 40),
                      _BalanceAction(icon: Icons.history_rounded, label: 'Ledger', onTap: () {}),
                      const SizedBox(width: 40),
                      _BalanceAction(icon: Icons.settings_outlined, label: 'Setelan', onTap: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tactical Banner: "You are owed"
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.success),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Kamu ditagih Rp 1.200.000 di beberapa grup.',
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Bayar', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Project/Group List
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text(
                  'Grup Aktif',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.deepZinc),
                ),
                const SizedBox(height: 16),
                _GroupListItem(
                  title: 'Bali Trip 2026',
                  subtitle: '8 anggota • Proyek Liburan',
                  balance: 'Rp 14.500.000',
                  status: 'Tagihan Kamu: Rp 450.000',
                  statusColor: AppColors.error,
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _GroupListItem(
                  title: 'Dinner Bareng',
                  subtitle: '4 anggota • Makan Malam',
                  balance: 'Rp 920.000',
                  status: 'Kamu Lunas',
                  statusColor: AppColors.success,
                  onTap: () {},
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalanceAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _BalanceAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BouncyButton(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _GroupListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String balance;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;

  const _GroupListItem({
    required this.title,
    required this.subtitle,
    required this.balance,
    required this.status,
    required this.statusColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.folder_shared_rounded, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.deepZinc)),
                  Text(subtitle, style: const TextStyle(color: AppColors.brandGray, fontSize: 12)),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(balance, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const Icon(Icons.chevron_right, color: AppColors.brandGray),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
