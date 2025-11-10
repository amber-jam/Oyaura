import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final String currentScreen;

  const CustomBottomNavBar({
    super.key,
    required this.currentScreen,
  });

  @override
  Widget build(BuildContext context) {
    // Define all possible screens and their icons
    final Map<String, IconData> screens = {
      'home': Icons.home,
      'mood': Icons.mood,
      'journal': Icons.book,
      'streak': Icons.local_fire_department,
      'leaderboard': Icons.leaderboard,
      'avatar': Icons.person,
      'goals': Icons.track_changes,
      'routine': Icons.schedule,
    };

    // Remove current screen from the list and ensure home is available if not current
    Map<String, IconData> navigationScreens = Map.from(screens);
    if (currentScreen != 'home') {
      navigationScreens.remove(currentScreen);
    }
    
    // Ensure we only show 6 items (plus home in middle if not current screen)
    List<MapEntry<String, IconData>> displayItems = navigationScreens.entries.take(6).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...displayItems.take(3).map((entry) => _buildNavItem(context, entry.key, entry.value)),
            if (currentScreen != 'home')
              _buildNavItem(context, 'home', Icons.home, isHome: true)
            else
              _buildNavItem(context, currentScreen, screens[currentScreen]!, isHome: true),
            ...displayItems.skip(3).map((entry) => _buildNavItem(context, entry.key, entry.value)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String screen, IconData icon, {bool isHome = false}) {
    final bool isSelected = screen == currentScreen;
    
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushNamed(context, '/$screen');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFA4A4).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFFA4A4) : Colors.grey,
              size: isHome ? 32 : 24,
            ),
            if (!isHome) const SizedBox(height: 4),
            if (!isHome)
              Text(
                screen[0].toUpperCase() + screen.substring(1),
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? const Color(0xFFFFA4A4) : Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}