import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Aktivitas Sosial'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Teman'),
            Tab(text: 'Publik'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedList(true),  // Friends Feed
          _buildFeedList(false), // Public Feed
        ],
      ),
    );
  }

  Widget _buildFeedList(bool isFriends) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${index + (isFriends ? 10 : 100)}'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(color: AppColors.deepZinc, fontSize: 14),
                            children: [
                              TextSpan(
                                text: isFriends ? 'Sarah ' : 'Anonim ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const TextSpan(text: 'patungan '),
                              const TextSpan(
                                text: 'Dinner BBQ',
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        const Text('2 jam yang lalu', style: TextStyle(color: AppColors.brandGray, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Text('🍕', style: TextStyle(fontSize: 24)),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Makan-makan seru bareng tim! Makasih semuanya yang udah bayar tepat waktu. 🙏',
                style: TextStyle(height: 1.4, color: AppColors.deepZinc),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const _SocialAction(icon: Icons.favorite_border, label: '12'),
                  const SizedBox(width: 16),
                  const _SocialAction(icon: Icons.comment_outlined, label: '3'),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Split Bill',
                      style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SocialAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SocialAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.brandGray),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.brandGray, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
