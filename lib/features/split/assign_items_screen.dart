import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';

class AssignItemsScreen extends StatefulWidget {
  const AssignItemsScreen({super.key});

  @override
  State<AssignItemsScreen> createState() => _AssignItemsScreenState();
}

class _AssignItemsScreenState extends State<AssignItemsScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Nasi Goreng Spesial', 'price': 45000, 'assigned': ['You']},
    {'name': 'Es Teh Manis', 'price': 12000, 'assigned': []},
    {'name': 'Sate Ayam (10 Tusuk)', 'price': 38000, 'assigned': ['Budi']},
    {'name': 'Kerupuk Kaleng', 'price': 5000, 'assigned': []},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bagi Tagihan'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Edit Resi', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Column(
        children: [
          // AI Scan Success Banner
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            color: AppColors.success.withValues(alpha: 0.1),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome, color: AppColors.success, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'AI Scan Berhasil: 4 item ditemukan',
                    style: TextStyle(color: AppColors.success, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                final isUnassigned = (item['assigned'] as List).isEmpty;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: isUnassigned ? Border.all(color: AppColors.error.withValues(alpha: 0.3)) : null,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isUnassigned ? Icons.help_outline : Icons.shopping_bag_outlined,
                          color: isUnassigned ? AppColors.error : AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['name'],
                              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.deepZinc),
                            ),
                            Text(
                              'Rp ${item['price']}',
                              style: const TextStyle(color: AppColors.brandGray, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      if (!isUnassigned)
                        Wrap(
                          spacing: -8,
                          children: (item['assigned'] as List).map((name) => CircleAvatar(
                            radius: 14,
                            backgroundColor: AppColors.primary,
                            child: Text(name[0], style: const TextStyle(fontSize: 10, color: Colors.white)),
                          )).toList(),
                        )
                      else
                        const Text(
                          'Belum Terpilih',
                          style: TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Bottom Summary Action
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 20),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Terbagi', style: TextStyle(color: AppColors.brandGray)),
                    Text('Rp 100.000 / Rp 100.000', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                BouncyButton(
                  onTap: () => Navigator.pushNamed(context, '/home'),
                  child: Container(
                    height: 56,
                    alignment: Alignment.center,
                    decoration: const ShapeDecoration(
                      shape: StadiumBorder(),
                      color: AppColors.primary,
                    ),
                    child: const Text(
                      'Kirim Permintaan Pembayaran',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
