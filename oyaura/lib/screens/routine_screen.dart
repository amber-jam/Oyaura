import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'routine'),
      appBar: AppBar(
        title: const Text('Routine Tracker'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Routine Tracker - Coming Soon'),
      ),
    );
  }
}