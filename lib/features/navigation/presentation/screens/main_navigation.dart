import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/screens/neo_dashboard_screen.dart';
import '../../../map/presentation/screens/interactive_map_screen.dart';
// Bookings removed from bottom nav; accessible via Home quick action
import '../../../host/presentation/screens/host_dashboard_screen.dart';
// Removed Host and Analytics from bottom nav to reduce items
import '../../../profile/presentation/screens/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const NeoDashboardScreen(),
    const InteractiveMapScreen(),
    const HostDashboardScreen(),
    const ProfileScreen(),
  ];

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
        icon: Icons.auto_awesome_rounded,
        label: 'Home',
        color: AppTheme.secondary),
    NavigationItem(icon: Icons.map, label: 'Map', color: AppTheme.primary),
    NavigationItem(icon: Icons.home, label: 'Host', color: AppTheme.accent),
    NavigationItem(
      icon: Icons.person,
      label: 'Profile',
      color: AppTheme.neutral600,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.md,
              vertical: AppConstants.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _navigationItems.length,
                (index) => Flexible(
                  child: _buildNavigationItem(index),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationItem(int index) {
    final item = _navigationItems[index];
    final isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.md,
          vertical: AppConstants.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? item.color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(AppConstants.sm),
              decoration: BoxDecoration(
                color: isSelected ? item.color : Colors.transparent,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
              child: Icon(
                item.icon,
                size: 24,
                color: isSelected ? Colors.white : AppTheme.neutral500,
              ),
            )
                .animate(target: isSelected ? 1 : 0)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1))
                .then()
                .shimmer(duration: const Duration(milliseconds: 500)),
            const SizedBox(height: AppConstants.xs),
            Flexible(
              child: Text(
                item.label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? item.color : AppTheme.neutral500,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final Color color;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}
