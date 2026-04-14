import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import '../../core/widgets/glass_container.dart';
import '../feed/feed_screen.dart';
import '../groups/groups_screen.dart';
import '../wallet/wallet_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const WalletScreen(), // Home Dashboard
    const FeedScreen(),   // Social Feed
    const SizedBox(),     // Middle Placeholder for floating action
    const GroupsScreen(), // Groups Hub
    const ProfileScreen(), // Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(vertical: 8),
          borderRadius: 32,
          opacity: 0.95, 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.grid_view_rounded, 
                isSelected: _currentIndex == 0, 
                onTap: () => setState(() => _currentIndex = 0),
              ),
              _NavIcon(
                icon: Icons.rss_feed_rounded, 
                isSelected: _currentIndex == 1, 
                onTap: () => setState(() => _currentIndex = 1),
              ),
              // Stitch Main Action Button
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/split'),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
                ),
              ),
              _NavIcon(
                icon: Icons.group_work_rounded, 
                isSelected: _currentIndex == 3, 
                onTap: () => setState(() => _currentIndex = 3),
              ),
              _NavIcon(
                icon: Icons.person_rounded, 
                isSelected: _currentIndex == 4, 
                onTap: () => setState(() => _currentIndex = 4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavIcon({required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? AppColors.primary : AppColors.brandGray.withOpacity(0.5),
        size: 26,
      ),
      onPressed: onTap,
    );
  }
}
