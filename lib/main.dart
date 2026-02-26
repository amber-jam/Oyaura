import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Your actual Supabase Database Connection!
  await Supabase.initialize(
    url: 'https://zkxfwoliehxgrqybiwux.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpreGZ3b2xpZWh4Z3JxeWJpd3V4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk5ODQwNTcsImV4cCI6MjA4NTU2MDA1N30.F7KIUqPsakzvdgDPxNGTh5A4jts5Y2OABr_-gkF1DFg',
  );

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
