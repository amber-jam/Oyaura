import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'avatar'),
      appBar: AppBar(
        title: const Text('Avatar'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: const Center(
        child: Text('Avatar Customization - Coming Soon'),
      ),
    );
  }
}