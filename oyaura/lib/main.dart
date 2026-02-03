import 'package:flutter/material.dart';
import 'screens/startup_screen.dart';
import 'screens/homescreen_ui.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/moodtracker_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/streak_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/avatar_screen.dart';
import 'screens/goals_screen.dart';
import 'screens/routine_screen.dart';

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
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/mood': (context) => const MoodTrackerScreen(),
        '/home': (context) => const HomeScreenUI(),
        '/journal': (context) => const JournalScreen(),
        '/streak': (context) => const StreakScreen(),
        '/leaderboard': (context) => LeaderboardScreen(),
        '/avatar': (context) => const AvatarUI(),
        '/goals': (context) => const GoalMakerUI(),
        '/routine': (context) => const RoutineScreen(),
      },
    );
  }
}

