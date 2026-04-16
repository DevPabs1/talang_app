import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../providers/wallet_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawScreen extends ConsumerStatefulWidget {
  const WithdrawScreen({super.key});

  @override
  ConsumerState<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends ConsumerState<WithdrawScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedBank;

  final List<Map<String, String>> _banks = [
    {'name': 'BCA', 'code': '014'},
    {'name': 'Mandiri', 'code': '008'},
    {'name': 'BNI', 'code': '009'},
    {'name': 'Permata', 'code': '013'},
  ];

  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(walletBalanceProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tarik Saldo'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tarik ke Rekening Bank',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Saldo tersedia: Rp ${balance.toStringAsFixed(0)}',
                style: const TextStyle(color: AppColors.zinc500),
              ),
              const SizedBox(height: 32),
              
              // Bank Selector
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Pilih Bank Tujuan',
                  prefixIcon: Icon(Icons.account_balance_outlined),
                ),
                initialValue: _selectedBank,
                items: _banks.map((bank) {
                  return DropdownMenuItem(
                    value: bank['name'],
                    child: Text(bank['name']!),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedBank = val),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _amountController,
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(fontSize: 48, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
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
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final amount = double.tryParse(_amountController.text) ?? 0;
                  if (amount <= 0 || _selectedBank == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lengkapi data penarikan')));
                    return;
                  }
                  if (amount > balance) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saldo tidak mencukupi')));
                    return;
                  }

                  // Confirm PIN Mock
                  _showPinDialog(context, amount);
                },
                child: const Text('Tarik Sekarang'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPinDialog(BuildContext context, double amount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Masukkan PIN'),
        content: const TextField(
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(hintText: '******'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(
            onPressed: () {
              ref.read(walletBalanceProvider.notifier).state = ref.read(walletBalanceProvider) - amount;
              Navigator.pop(context); // Close PIN
              Navigator.pop(context); // Close Withdraw
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Penarikan sedang diproses')));
            },
            child: const Text('Konfirmasi'),
          ),
        ],
      ),
    );
  }
}
