import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _nameController = TextEditingController();
  String _selectedCategory = 'Liburan';

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Liburan', 'icon': Icons.beach_access_rounded},
    {'name': 'Makan Malam', 'icon': Icons.restaurant_rounded},
    {'name': 'Tagihan', 'icon': Icons.receipt_long_rounded},
    {'name': 'Rumah Tangga', 'icon': Icons.home_rounded},
    {'name': 'Lainnya', 'icon': Icons.more_horiz_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Buat Grup Baru'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.deepZinc,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Beri Nama Grup Kamu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.deepZinc),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Misal: Bali Trip 2026',
                  prefixIcon: Icon(Icons.group_work_outlined),
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Pilih Kategori',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepZinc),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat['name'];
                  return InkWell(
                    onTap: () => setState(() => _selectedCategory = cat['name']),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : AppColors.background,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cat['icon'],
                            color: isSelected ? AppColors.primary : AppColors.brandGray,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            cat['name'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? AppColors.primary : AppColors.brandGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),
              const Text(
                'Undang Anggota',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.deepZinc),
              ),
              const SizedBox(height: 16),
              _buildAddMemberTile(context),
              
              const SizedBox(height: 60),
              BouncyButton(
                onTap: () {
                  // Simulate creation
                  Navigator.pop(context);
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(),
                    color: AppColors.primary,
                  ),
                  child: const Text(
                    'Lanjutkan',
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

  Widget _buildAddMemberTile(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_add_outlined, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tambah dari Kontak', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.deepZinc)),
                Text('Atau cari dengan nomor HP', style: TextStyle(fontSize: 12, color: AppColors.brandGray)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.brandGray),
        ],
      ),
    );
  }
}
