import 'package:flutter/material.dart';

const _accent = Color(0xFFF4A3A3);
const _muted = Color(0xFF7A8087);
const _g = 16.0;

class CustomBottomNavBar extends StatelessWidget {
  final String currentScreen;

  const CustomBottomNavBar({
    super.key,
    required this.currentScreen,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, IconData> screens = {
      'home': Icons.home_rounded,
      'mood': Icons.emoji_emotions_rounded,
      'journal': Icons.book_rounded,
      'streak': Icons.local_fire_department_rounded,
      'leaderboard': Icons.leaderboard_rounded,
      'avatar': Icons.person_rounded,
      'goals': Icons.flag_rounded,
      'routine': Icons.schedule_rounded,
    };

    // Remove current screen from outer list (except home)
    final List<MapEntry<String, IconData>> outerItems = screens.entries
        .where((entry) => entry.key != currentScreen && entry.key != 'home')
        .toList();

    // Ensure we only show 6 items around home
    final List<MapEntry<String, IconData>> displayItems = outerItems.take(6).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withAlpha((0.3 * 255).round()),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: _g),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...displayItems.take(3).map((entry) => _NavDot(
                screen: entry.key,
                icon: entry.value,
                isSelected: entry.key == currentScreen,
              )),
          _NavDot(
            screen: 'home',
            icon: screens['home']!,
            isSelected: currentScreen == 'home',
            isHome: true,
          ),
          ...displayItems.skip(3).map((entry) => _NavDot(
                screen: entry.key,
                icon: entry.value,
                isSelected: entry.key == currentScreen,
              )),
        ],
      ),
    );
  }
}

class _NavDot extends StatelessWidget {
  final String screen;
  final IconData icon;
  final bool isSelected;
  final bool isHome;

  const _NavDot({
    required this.screen,
    required this.icon,
    required this.isSelected,
    this.isHome = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushNamed(context, '/$screen');
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? _accent.withAlpha((0.2 * 255).round()) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? _accent : _muted,
              size: isHome ? 32 : 24,
            ),
            if (!isHome) const SizedBox(height: 4),
            if (!isHome)
              Text(
                screen[0].toUpperCase() + screen.substring(1),
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? _accent : _muted,
                ),
              ),
          ],
        ),
      ),
    );
  }
}