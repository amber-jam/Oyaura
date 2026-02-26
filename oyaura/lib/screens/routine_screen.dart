import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/mobile_layout.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color softPink = const Color(0xFFFFF5F5);
    final Color softYellow = const Color(0xFFFFF9D5);
    final Color accentColor = const Color(0xFFDC143C);

    final List<String> days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];
    final List<Map<String, dynamic>> habits = [
      {'label': 'Skincare', 'icon': Icons.spa, 'completed': true},
      {'label': 'Hydration', 'icon': Icons.local_drink, 'completed': true},
      {'label': 'Relaxation', 'icon': Icons.self_improvement, 'completed': false},
    ];

    return MobileLayout(
      currentScreen: 'routine',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affirmation
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: softYellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Believe in yourself and you will be UNSTOPPABLE.',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 24),

            // Weekly Tracker
            Text('Weekly Tracker',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentColor, width: 1.5),
                  ),
                  child: Center(
                    child: Text(
                      day,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            // Habit Tracker
            Text('Habit Tracker',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: habits.map((habit) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: accentColor, width: 1.5),
                      ),
                      child: Icon(
                        habit['icon'],
                        color: habit['completed'] ? accentColor : Colors.grey,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      habit['label'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),

            const Spacer(),

            // Profile Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to profile
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Profile',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}