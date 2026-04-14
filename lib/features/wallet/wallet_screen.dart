import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/nebula_card.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/feed_provider.dart';

class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(walletBalanceProvider);
    final history = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Stitch Deep Sync: Curved Wave Header
          SliverToBoxAdapter(
            child: ClipPath(
              clipper: HeaderWaveClipper(),
              child: Container(
                padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 60),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Selamat Malam,',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            Text(
                              'Budi Santoso',
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: 24, 
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            _IconBadge(icon: Icons.notifications_none),
                            const SizedBox(width: 12),
                            CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=budi'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    NebulaCard(balance: balance),
                  ],
                ),
              ),
            ),
          ),

          // Stitch: Pending Request Banner (Pill Button + 32px)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.15)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.receipt_long_rounded, color: AppColors.accent),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Menunggu Pembayaran',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            'Budi: Rp 50.000',
                            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        minimumSize: const Size(70, 40),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      child: const Text('Bayar', style: TextStyle(fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Quick Actions Row (Standardized 32px)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const Text(
                    'Layanan Utama',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.deepZinc),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _QuickActionItem(
                        icon: Icons.send_rounded, 
                        label: 'Kirim', 
                        onTap: () => Navigator.pushNamed(context, '/transfer'),
                      ),
                      _QuickActionItem(
                        icon: Icons.qr_code_scanner_rounded, 
                        label: 'Scan QR', 
                        onTap: () {},
                      ),
                      _QuickActionItem(
                        icon: Icons.account_balance_wallet_rounded, 
                        label: 'Tarik', 
                        onTap: () => Navigator.pushNamed(context, '/withdraw'),
                      ),
                      _QuickActionItem(
                        icon: Icons.add_circle_outline_rounded, 
                        label: 'Split', 
                        onTap: () => Navigator.pushNamed(context, '/split'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Activity Feed
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Aktivitas Sosial',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: AppColors.deepZinc),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/history'),
                    child: const Text('Lihat Semua', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: history.isEmpty 
              ? SliverToBoxAdapter(child: _buildEmptyShimmer())
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = history[index];
                      final isSocial = index % 2 == 0;
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32), // Deep Sync: 32px
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
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${item.receiver}'),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.receiver} membayar Dinner BBQ',
                                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.deepZinc),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '2m ago • Publik',
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                                        ),
                                        const SizedBox(width: 8),
                                        _CategoryChip(label: isSocial ? 'Sosial' : 'Split', active: isSocial),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.bolt_rounded, color: AppColors.primary, size: 24),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: history.length,
                  ),
                ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildEmptyShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.zinc100,
      highlightColor: Colors.white,
      child: Column(
        children: List.generate(3, (i) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
        )),
      ),
    );
  }
}

class HeaderWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height - 20);
    path.quadraticBezierTo(3 * size.width / 4, size.height - 40, size.width, size.height - 10);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  const _IconBadge({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool active;
  const _CategoryChip({required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: (active ? AppColors.success : AppColors.accent).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? AppColors.success : AppColors.accent,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.primary, size: 30),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.brandGray),
        ),
      ],
    );
  }
}
