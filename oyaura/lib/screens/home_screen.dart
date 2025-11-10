import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    final String greeting = getGreeting();
    final int moodStreak = 5;
    final double avgIntensity = 3.7;
    final String topMood = '😊';
    final double goalProgress = 0.65; // 65% toward goal

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '$greeting, Asia 👋',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFDC143C),
                  ),
                ),
              ),
            ),

            // Avatar
            const SizedBox(height: 12),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),

            // Daily Prompt
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Today’s Focus: Stay hydrated and check in with your mood 💧',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),

            // Stats Section
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Mood Streak: $moodStreak days',
                      style: GoogleFonts.playfairDisplay(fontSize: 18)),
                  Text('- Avg Intensity: ${avgIntensity.toStringAsFixed(1)}',
                      style: GoogleFonts.playfairDisplay(fontSize: 18)),
                  Text('- Top Mood: $topMood',
                      style: GoogleFonts.playfairDisplay(fontSize: 18)),
                ],
              ),
            ),

            // Goal Progress Ring
            const SizedBox(height: 32),
            Column(
              children: [
                Text(
                  'Goal Progress',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFDC143C),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: goalProgress,
                        strokeWidth: 8,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFDC143C)),
                      ),
                      Text(
                        '${(goalProgress * 100).toInt()}%',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFFDC143C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Bottom Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 16,
                children: [
                  _NavIcon(icon: Icons.edit, label: 'Mood', onTap: () {
                    Navigator.pushNamed(context, '/mood');
                  }),
                  _NavIcon(icon: Icons.local_fire_department, label: 'Streaks', onTap: () {
                    Navigator.pushNamed(context, '/streaks');
                  }),
                  _NavIcon(icon: Icons.flag, label: 'Goals', onTap: () {
                    Navigator.pushNamed(context, '/goals');
                  }),
                  _NavIcon(icon: Icons.access_time, label: 'Routine', onTap: () {
                    Navigator.pushNamed(context, '/routine');
                  }),
                  _NavIcon(icon: Icons.book, label: 'Journal', onTap: () {
                    Navigator.pushNamed(context, '/journal');
                  }),
                  _NavIcon(icon: Icons.leaderboard, label: 'Leaderboard', onTap: () {
                    Navigator.pushNamed(context, '/leaderboard');
                  }),
                  _NavIcon(icon: Icons.face, label: 'Avatar', onTap: () {
                    Navigator.pushNamed(context, '/avatar');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavIcon({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            child: Icon(icon, size: 20, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(label, style: GoogleFonts.playfairDisplay(fontSize: 14)),
        ],
      ),
    );
  }
}