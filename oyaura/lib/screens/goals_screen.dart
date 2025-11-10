import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'goals'),
      appBar: AppBar(
        title: const Text('Goals & Habits'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Goals & Habits Tracker - Coming Soon'),
      ),
    );
  }
}