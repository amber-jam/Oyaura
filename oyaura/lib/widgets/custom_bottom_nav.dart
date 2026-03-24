import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

const _accent = Color(0xFFF4A3A3);
const _muted = Color(0xFF7A8087);

// Scrollable bottom navigation bar constrained for mobile views.
class CustomBottomNavBar extends StatelessWidget {
  final String currentScreen;

  const CustomBottomNavBar({super.key, required this.currentScreen});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tabs = [
      {'name': 'home', 'icon': Icons.home_rounded, 'label': 'Home'},
      {'name': 'mood', 'icon': Icons.emoji_emotions_rounded, 'label': 'Mood'},
      {'name': 'journal', 'icon': Icons.book_rounded, 'label': 'Journal'},
      {
        'name': 'streak',
        'icon': Icons.local_fire_department_rounded,
        'label': 'Streak',
      },
      {'name': 'goals', 'icon': Icons.flag_rounded, 'label': 'Goals'},
      {'name': 'routine', 'icon': Icons.schedule_rounded, 'label': 'Routine'},
      {
        'name': 'leaderboard',
        'icon': Icons.leaderboard_rounded,
        'label': 'Rank',
      },
      {'name': 'avatar', 'icon': Icons.person_rounded, 'label': 'Avatar'},
    ];

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double containerWidth = constraints.maxWidth > 450
              ? 450
              : constraints.maxWidth;
          double tabWidth = containerWidth / 4;

          return Container(
            height: 85,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withAlpha((0.3 * 255).round()),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            // Allows mouse dragging on web browsers
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: tabs.map((tab) {
                    return SizedBox(
                      width: tabWidth,
                      child: _NavDot(
                        screen: tab['name'],
                        label: tab['label'],
                        icon: tab['icon'],
                        isSelected: currentScreen == tab['name'],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NavDot extends StatelessWidget {
  final String screen;
  final String label;
  final IconData icon;
  final bool isSelected;

  const _NavDot({
    required this.screen,
    required this.label,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, '/$screen');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? _accent.withAlpha((0.2 * 255).round())
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? _accent : _muted, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? _accent : _muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
