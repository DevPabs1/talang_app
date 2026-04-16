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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.deepZinc),
          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
        ),
        title: const Text(
          'Talang',
          style: TextStyle(
            color: AppColors.primaryDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.primaryDark),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primaryLight,
              child: Icon(Icons.person, color: AppColors.primaryDark, size: 20),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              // Main Receipt Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.restaurant, color: AppColors.primaryDark, size: 40),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Paid $receiver',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.brandGray,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${amount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 48,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F9F9), // Light cyan background
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle, color: AppColors.primaryDark, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'SUCCESS',
                            style: TextStyle(
                              color: AppColors.primaryDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Date & Time Card
              _buildInfoCard(
                context,
                title: 'DATE & TIME',
                value: 'Oct 24, 2023',
                subtitle: '08:45 PM',
              ),
              const SizedBox(height: 16),

              // Payment Method Card
              _buildInfoCard(
                context,
                title: 'PAYMENT METHOD',
                valueRow: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    const Text('•••• 4421', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Transaction ID Card
              _buildInfoCard(
                context,
                title: 'TRANSACTION ID',
                value: 'TXN-98234-BALI-0922',
                trailing: const Icon(Icons.copy, color: AppColors.brandGray, size: 20),
              ),
              const SizedBox(height: 16),

              // Shared With Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    // Stacked Avatars
                    SizedBox(
                      width: 90,
                      height: 40,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                          ),
                          Positioned(
                            left: 25,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[400],
                              child: const Icon(Icons.person, color: Colors.white),
                            ),
                          ),
                          const Positioned(
                            left: 50,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryLight,
                              child: Text('+3', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shared with Sarah & 4 others',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
                          ),
                          Text(
                            'Split request pending',
                            style: TextStyle(color: AppColors.brandGray, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Actions
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_comment, color: Colors.white),
                label: const Text('Add Comment', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share, color: Colors.black),
                label: const Text('Share Receipt', style: TextStyle(color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFE2E8F0), // slate-200
                  side: BorderSide.none,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    String? value,
    Widget? valueRow,
    String? subtitle,
    Widget? trailing,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9), // slate-100
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.brandGray,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                if (value != null)
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                if (valueRow != null) valueRow,
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.brandGray,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
