import 'package:flutter/material.dart';
import 'screens/startup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/moodtracker_screen.dart';

void main() {
  runApp(OyauraApp());
}

class OyauraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oyaura Wellness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => StartupScreen(),
        '/mood': (context) => const MoodTrackerScreen(),
        '/signup': (context) => HomeScreen(),
      },
    );
  }
}

