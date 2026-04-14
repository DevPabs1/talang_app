import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class TransferSuccessScreen extends StatelessWidget {
  final double amount;
  final String receiver;

  const TransferSuccessScreen({
    super.key,
    required this.amount,
    required this.receiver,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Celebratory Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: AppColors.primary, size: 80),
              ),
              const SizedBox(height: 32),
              Text(
                'Pembayaran Berhasil!',
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Uang kamu telah terkirim kepada $receiver',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48),
              
              // Receipt Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.zinc50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    _ReceiptRow(label: 'Total Transfer', value: 'Rp ${amount.toStringAsFixed(0)}', isBold: true),
                    const Divider(height: 32),
                    const _ReceiptRow(label: 'Metode Pembayaran', value: 'Talang Wallet'),
                    const SizedBox(height: 12),
                    const _ReceiptRow(label: 'Waktu', value: '12 Apr 2026, 20:55'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
                child: const Text('Kembali ke Beranda'),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
                onPressed: () {},
                child: const Text('Bagikan Bukti Transfer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _ReceiptRow({required this.label, required this.value, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
        )),
      ],
    );
  }
}
