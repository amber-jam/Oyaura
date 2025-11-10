import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'leaderboard'),
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Leaderboard - Coming Soon'),
      ),
    );
  }
}