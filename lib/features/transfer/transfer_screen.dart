import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/feed_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class TransferScreen extends ConsumerStatefulWidget {
  const TransferScreen({super.key});

  @override
  ConsumerState<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends ConsumerState<TransferScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _visibility = 'Public'; // Figma: Public, Friends, Private

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Kirim Uang'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Cari username atau kontak',
                  prefixIcon: Icon(Icons.search, size: 20),
                ),
              ),
              const SizedBox(height: 32),
              
              const Center(
                child: Text('Jumlah Transfer', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.zinc500)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _amountController,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 56, fontWeight: FontWeight.w800, letterSpacing: -2, color: AppColors.textPrimary),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0',
                  prefixText: 'Rp ',
                  prefixStyle: GoogleFonts.outfit(fontSize: 24, color: AppColors.zinc400),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                ),
              ),
              const SizedBox(height: 32),
              
              // Figma Privacy Pill Selector
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.zinc100,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _Pill(label: 'Public', isSelected: _visibility == 'Public', onTap: () => setState(() => _visibility = 'Public')),
                    _Pill(label: 'Friends', isSelected: _visibility == 'Friends', onTap: () => setState(() => _visibility = 'Friends')),
                    _Pill(label: 'Private', isSelected: _visibility == 'Private', onTap: () => setState(() => _visibility = 'Private')),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: 'Kasih catatan... (Opsional)',
                  prefixIcon: Icon(Icons.edit_note, size: 20),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(_amountController.text) ?? 0;
                  final currentBalance = ref.read(walletBalanceProvider);
                  
                  if (amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Masukkan nominal transfer')));
                    return;
                  }
                  
                  if (amount > currentBalance) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saldo tidak mencukupi')));
                    return;
                  }

                  // Deduct Balance
                  ref.read(walletBalanceProvider.notifier).state = currentBalance - amount;

                  // Add to Feed
                  const receiver = 'Kiro Studio';
                  final note = _noteController.text.isNotEmpty ? _noteController.text : 'Transfer';
                  if (_visibility != 'Private') {
                    ref.read(feedProvider.notifier).addTransaction(receiver, note);
                  }

                  // Figma Celebration: Navigate to Success Screen
                  Navigator.pushReplacementNamed(
                    context, 
                    '/success', 
                    arguments: {'amount': amount, 'receiver': receiver}
                  );
                },
                child: const Text('Lanjutkan Transfer'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _Pill({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2)),
            ] : null,
          ),
          child: Center(
            child: Text(
              label, 
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.zinc500,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
