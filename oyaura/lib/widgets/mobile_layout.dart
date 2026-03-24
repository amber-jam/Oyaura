import 'package:flutter/material.dart';
import 'custom_bottom_nav.dart';

// Locks the entire screen inside a centered 450px mobile view.

class MobileLayout extends StatelessWidget {
  final Widget child;
  final String currentScreen;
  final bool showNavBar;

  const MobileLayout({
    super.key,
    required this.child,
    required this.currentScreen,
    this.showNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    // Outer scaffold acts as the grey browser background
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          // Inner scaffold acts as the physical mobile phone screen
          child: Scaffold(
            backgroundColor: const Color(0xFFEFF8F7),
            body: SafeArea(child: child),
            bottomNavigationBar: showNavBar
                ? CustomBottomNavBar(currentScreen: currentScreen)
                : null,
          ),
        ),
      ),
    );
  }
}
