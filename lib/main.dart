import 'package:flutter/material.dart';
import 'Screens/homescreen_ui.dart';
import 'Screens/avatar_ui.dart';
import 'Screens/goalmaker_ui.dart';

void main() => runApp(const OyauraApp());

class OyauraApp extends StatelessWidget {
  const OyauraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oyaura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF4A3A3)),
        useMaterial3: true,
        fontFamily: 'SF Pro',
      ),
      routes: {
        '/': (_) => const HomeScreenUI(),
        '/avatar': (_) => const AvatarUI(),
        '/goalmaker': (_) => const GoalMakerUI(),
      },
    );
  }
}