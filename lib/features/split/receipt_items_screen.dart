import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/bouncy_button.dart';

class ReceiptItemsScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? initialItems;
  const ReceiptItemsScreen({super.key, this.initialItems});

  @override
  State<ReceiptItemsScreen> createState() => _ReceiptItemsScreenState();
}

class _ReceiptItemsScreenState extends State<ReceiptItemsScreen> {
  late List<Map<String, dynamic>> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.initialItems ?? [
      {'name': '2x Pizza Margherita', 'price': 240000.0, 'assigned': ['Anda']},
      {'name': '1x Garlic Bread', 'price': 45000.0, 'assigned': []},
      {'name': '4x Coca Cola', 'price': 80000.0, 'assigned': []},
      {'name': '1x Service Charge', 'price': 36500.0, 'assigned': ['Semua']},
    ];
  }

  final List<Map<String, dynamic>> _crew = [
    {'name': 'Anda', 'avatar': 'https://i.pravatar.cc/150?u=you'},
    {'name': 'Budi', 'avatar': 'https://i.pravatar.cc/150?u=budi'},
    {'name': 'Siti', 'avatar': 'https://i.pravatar.cc/150?u=siti'},
    {'name': 'Agus', 'avatar': 'https://i.pravatar.cc/150?u=agus'},
    {'name': 'Semua', 'avatar': 'https://i.pravatar.cc/150?u=all'},
  ];

  double get _totalStruk => _items.fold(0.0, (sum, item) => sum + item['price']);
  double get _totalTerbagi => _items.fold(0.0, (sum, item) {
    if ((item['assigned'] as List).isEmpty) return sum;
    return sum + item['price'];
  });

  void _onAssign(int itemIndex, String memberName) {
    setState(() {
      final item = _items[itemIndex];
      final assigned = List<String>.from(item['assigned']);
      
      if (memberName == 'Semua') {
        item['assigned'] = ['Semua'];
      } else {
        if (assigned.contains('Semua')) assigned.remove('Semua');
        if (!assigned.contains(memberName)) {
          assigned.add(memberName);
          item['assigned'] = assigned;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isAllAssigned = _totalTerbagi >= _totalStruk;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Bagi Tagihan Struk'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.deepZinc,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                 for (var item in _items) {
                   item['assigned'] = [];
                 }
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          // Calculation Banner
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            color: isAllAssigned ? AppColors.success.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.05),
            child: Row(
              children: [
                Icon(
                  isAllAssigned ? Icons.check_circle : Icons.touch_app, 
                  color: isAllAssigned ? AppColors.success : AppColors.primary, 
                  size: 16
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isAllAssigned 
                      ? 'Semua item telah terbagi!' 
                      : 'Belum semua item terbagi (Rp ${(_totalStruk - _totalTerbagi).toInt()})',
                    style: TextStyle(
                      color: isAllAssigned ? AppColors.success : AppColors.primary, 
                      fontWeight: FontWeight.bold, 
                      fontSize: 13
                    ),
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
                return DragTarget<String>(
                  onWillAcceptWithDetails: (details) => true,
                  onAcceptWithDetails: (details) => _onAssign(index, details.data),
                  builder: (context, candidateData, rejectedData) {
                    final isHighlighted = candidateData.isNotEmpty;
                    final isAssigned = (item['assigned'] as List).isNotEmpty;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isHighlighted 
                              ? AppColors.primary 
                              : (isAssigned ? AppColors.border : AppColors.error.withValues(alpha: 0.3)),
                            width: isHighlighted ? 2 : 1,
                          ),
                          boxShadow: isHighlighted ? [
                            BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 10)
                          ] : [],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 16, 
                                      color: isAssigned ? AppColors.deepZinc : AppColors.error
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${item['price']}',
                                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            // Assignment Chips
                            Wrap(
                              spacing: -10,
                              children: [
                                if (item['assigned'].isEmpty)
                                  const Icon(Icons.person_add_outlined, color: AppColors.brandGray)
                                else
                                  ...item['assigned'].map((a) {
                                    final member = _crew.firstWhere((m) => m['name'] == a);
                                    return CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundImage: NetworkImage(member['avatar']),
                                      ),
                                    );
                                  }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          
          // Bottom Summary
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5)),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Struk', style: TextStyle(color: AppColors.brandGray)),
                      Text(
                        'Rp ${_totalTerbagi.toInt()} / Rp ${_totalStruk.toInt()}', 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  BouncyButton(
                    onTap: isAllAssigned ? () => Navigator.pushNamed(context, '/home') : null,
                    child: Opacity(
                      opacity: isAllAssigned ? 1.0 : 0.5,
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        decoration: const ShapeDecoration(
                          shape: StadiumBorder(),
                          color: AppColors.primary,
                        ),
                        child: const Text(
                          'Konfirmasi Pembagian',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Crew Tray
          Container(
            padding: const EdgeInsets.only(bottom: 24, top: 12),
            color: Colors.white,
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _crew.length,
              itemBuilder: (context, index) {
                final member = _crew[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Draggable<String>(
                    data: member['name'],
                    feedback: Material(
                      color: Colors.transparent,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.5),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(member['avatar']),
                        ),
                      ),
                    ),
                    childWhenDragging: Opacity(opacity: 0.3, child: _buildCrewAvatar(member)),
                    child: _buildCrewAvatar(member),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCrewAvatar(Map<String, dynamic> member) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(member['avatar']),
        ),
        const SizedBox(height: 4),
        Text(member['name'], style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
