import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> affirmations = [
    "You're doing better than you think 💫",
    "Small steps count. Keep going 🌱",
    "Your mood matters. You're seen 💖",
  ];

  int currentAffirmation = 0;

  @override
  void initState() {
    super.initState();
    _cycleAffirmations();
  }

  void _cycleAffirmations() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      setState(() {
        currentAffirmation = (currentAffirmation + 1) % affirmations.length;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final String greeting = getGreeting();
    final int moodStreak = 5;
    final double avgIntensity = 3.7;
    final String topMood = '😊';
    final Color accentColor = Colors.teal[800]!;

    return Scaffold(
      backgroundColor: const Color(0xFFFCF9EA),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'home'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Greeting
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Center(
                  child: Text(
                    '$greeting, Asia 👋',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: accentColor,
                    ),
                  ),
                ),
              ),

              // Affirmation Banner
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    affirmations[currentAffirmation],
                    key: ValueKey(currentAffirmation),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              // Avatar
              const SizedBox(height: 16),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),

              // Daily Focus
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Today’s Focus: Stay hydrated and check in with your mood 💧',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFDC143C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Streak + Leaderboard Boxes
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFCF9EA),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: accentColor, width: 1.5),
                        ),
                        child: Text(
                          '🔥 Streak: $moodStreak days',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFFFCF9EA),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: accentColor, width: 1.5),
                        ),
                        child: Text(
                          '🏆 Leaderboard: #12',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // "In your feelings..." box
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Stats',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFCF9EA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: accentColor, width: 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('- Mood Streak: $moodStreak days',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('- Avg Intensity: ${avgIntensity.toStringAsFixed(1)}',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Text('- Top Mood: $topMood',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Mood Calendar Header
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Your week at a glance',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFDC143C),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Mood Calendar Row
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _MoodTile(emoji: '😊', label: 'Mon'),
                      _MoodTile(emoji: '😐', label: 'Tue'),
                      _MoodTile(emoji: '😢', label: 'Wed'),
                      _MoodTile(emoji: '😄', label: 'Thu'),
                      _MoodTile(emoji: '😴', label: 'Fri'),
                    ],
                  ),
                ),
              ),

              // Feature Boxes Row
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _FeatureBox(
                      icon: Icons.edit,
                      label: 'Mood Tracker',
                      color: accentColor,
                      onTap: () {
                        Navigator.pushNamed(context, '/mood');
                      },
                    ),
                    const SizedBox(width: 12),
                    _FeatureBox(icon: Icons.flag, label: 'Goals & Habits', color: accentColor),
                    const SizedBox(width: 12),
                    _FeatureBox(icon: Icons.access_time, label: 'Routine Tracker', color: accentColor),
                  ],
                ),
              ),

              // Community Leaderboard Preview
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFCF9EA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: accentColor, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Community Leaderboard',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                          )),
                      const SizedBox(height: 12),
                      Text('🥇 Luna — 12-day streak',
                          style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('🥈 Kai — 10-day streak',
                          style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('🥉 River — 9-day streak',
                          style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ),
                ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }
}

// Mood Calendar Tile
class _MoodTile extends StatelessWidget {
  final String emoji;
  final String label;

  const _MoodTile({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFCF9EA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[800]!, width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Text(label,
              style: GoogleFonts.playfairDisplay(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}

// Feature Box Widget
class _FeatureBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _FeatureBox({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 28, color: color),
              const SizedBox(height: 10),
              Text(label,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}