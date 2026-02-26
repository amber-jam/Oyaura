import 'package:flutter/material.dart';
import '../widgets/mobile_layout.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      currentScreen: 'streak',
      child: const Center(child: Text('Streak Counter - Coming Soon')),
    );
  }
}
