import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../providers/feed_provider.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historyItems = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.zinc400,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Kirim'),
            Tab(text: 'Terima'),
            Tab(text: 'Tarik'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHistoryList(historyItems),
          _buildHistoryList(historyItems.where((i) => i.sender == 'You').toList()),
          _buildHistoryList(historyItems.where((i) => i.receiver == 'You').toList()),
          _buildHistoryList([]), // Tarik placeholder
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<FeedItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('Belum ada transaksi'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = items[index];
        final isNegative = item.sender == 'You' || item.sender == 'Hanson'; // Mocked logic

        return InkWell(
          onTap: () => _showTransactionDetail(context, item),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.zinc100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isNegative ? Icons.arrow_outward : Icons.arrow_downward,
                    size: 20,
                    color: isNegative ? AppColors.error : AppColors.success,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isNegative ? 'Ke ${item.receiver}' : 'Dari ${item.sender}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(item.time, style: const TextStyle(color: AppColors.zinc500, fontSize: 13)),
                    ],
                  ),
                ),
                Text(
                  '${isNegative ? '-' : '+'} Rp 50.000', // Mocked amount
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isNegative ? AppColors.error : AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTransactionDetail(BuildContext context, FeedItem item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Detail Transaksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 32),
              const Icon(Icons.check_circle, color: AppColors.success, size: 64),
              const SizedBox(height: 16),
              const Text('Berhasil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const Divider(height: 48),
              const _DetailRow(label: 'Total', value: 'Rp 50.000', isBold: true),
              const SizedBox(height: 12),
              _DetailRow(label: 'Tujuan', value: item.receiver),
              const SizedBox(height: 12),
              const _DetailRow(label: 'Waktu', value: '12 Apr 2026, 21:15'),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
                onPressed: () => Navigator.pop(context),
                child: const Text('Tutup'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _DetailRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.zinc500)),
        Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}
