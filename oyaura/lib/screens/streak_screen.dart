import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'streak'),
      appBar: AppBar(
        title: const Text('Streak Counter'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Streak Counter - Coming Soon'),
      ),
    );
  }
}