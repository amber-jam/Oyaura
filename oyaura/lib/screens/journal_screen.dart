import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'journal'),
      appBar: AppBar(
        title: const Text('Journal'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Journal Screen - Coming Soon'),
      ),
    );
  }
}