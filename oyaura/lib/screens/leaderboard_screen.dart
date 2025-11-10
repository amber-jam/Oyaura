import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_bottom_nav.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = const Color(0xFFDC143C);

    final List<Map<String, dynamic>> topUsers = [
      {'name': 'Luna', 'streak': 12, 'medal': '🥇'},
      {'name': 'Kai', 'streak': 10, 'medal': '🥈'},
      {'name': 'River', 'streak': 9, 'medal': '🥉'},
    ];

    final List<Map<String, dynamic>> fullLeaderboard = [
      {'rank': 4, 'name': 'Nova', 'streak': 8},
      {'rank': 5, 'name': 'Zane', 'streak': 7},
      {'rank': 6, 'name': 'Mira', 'streak': 6},
      {'rank': 7, 'name': 'Leo', 'streak': 6},
      {'rank': 8, 'name': 'Sage', 'streak': 5},
      {'rank': 9, 'name': 'Juno', 'streak': 5},
      {'rank': 10, 'name': 'Aria', 'streak': 5},
      {'rank': 11, 'name': 'Nico', 'streak': 5},
      {'rank': 12, 'name': 'Asia', 'streak': 5},
      {'rank': 13, 'name': 'Skye', 'streak': 4},
      {'rank': 14, 'name': 'Ezra', 'streak': 4},
      {'rank': 15, 'name': 'Indie', 'streak': 4},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'leaderboard'),
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: accentColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top 3
            Text('Top 3 Streaks',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                )),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: topUsers.map((user) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accentColor, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        Text(user['medal'], style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 6),
                        Text(user['name'],
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('${user['streak']} days',
                            style: GoogleFonts.playfairDisplay(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 28),
            Text('Your Position',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                )),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentColor, width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Asia',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                  Text('Rank #12 — 5-day streak',
                      style: GoogleFonts.playfairDisplay(fontSize: 16)),
                ],
              ),
            ),

            const SizedBox(height: 28),
            Text('Leaderboard',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: accentColor,
                )),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: fullLeaderboard.length,
                itemBuilder: (context, index) {
                  final user = fullLeaderboard[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: accentColor, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${user['rank']}. ${user['name']}',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('${user['streak']} days',
                            style: GoogleFonts.playfairDisplay(fontSize: 16)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}