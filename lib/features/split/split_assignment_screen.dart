import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import 'models/receipt_model.dart';

class SplitAssignmentScreen extends StatefulWidget {
  final List<ReceiptItem> items;
  const SplitAssignmentScreen({super.key, required this.items});

  @override
  State<SplitAssignmentScreen> createState() => _SplitAssignmentScreenState();
}

class _SplitAssignmentScreenState extends State<SplitAssignmentScreen> {
  late List<ReceiptItem> _currentItems;
  final List<Friend> _friends = mockFriends;

  @override
  void initState() {
    super.initState();
    _currentItems = widget.items;
  }

  void _toggleFriend(int itemIndex, String friendId) {
    setState(() {
      final item = _currentItems[itemIndex];
      final List<String> newIds = List.from(item.assignedFriendIds);
      if (newIds.contains(friendId)) {
        newIds.remove(friendId);
      } else {
        newIds.add(friendId);
      }
      _currentItems[itemIndex] = item.copyWith(assignedFriendIds: newIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Assign Items'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: _currentItems.length,
              itemBuilder: (context, index) {
                final item = _currentItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Text(
                            'Rp ${item.price.toStringAsFixed(0)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _friends.map((friend) {
                            final isSelected = item.assignedFriendIds.contains(friend.id);
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(friend.name.split(' ')[0]),
                                selected: isSelected,
                                onSelected: (_) => _toggleFriend(index, friend.id),
                                backgroundColor: AppColors.zinc100,
                                selectedColor: AppColors.primary.withValues(alpha: 0.2),
                                checkmarkColor: AppColors.primary,
                                labelStyle: TextStyle(
                                  color: isSelected ? AppColors.primary : AppColors.zinc600,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          // Total Summary Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Bill', style: TextStyle(color: Colors.white70)),
                      Text(
                        'Rp ${_calculateTotal().toStringAsFixed(0)}',
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tagihan berhasil dikirim ke teman-temanmu!')),
                      );
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                    child: const Text('Kirim Tagihan'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotal() {
    return _currentItems.fold(0, (sum, item) => sum + item.price);
  }
}
