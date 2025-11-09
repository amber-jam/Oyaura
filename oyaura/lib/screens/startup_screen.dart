import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _buttonController;
  late Animation<double> _logoFade;
  late Animation<double> _buttonFade;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _buttonFade = CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeIn,
    );

    _logoController.forward();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _buttonController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8F7), // ✅ Background color
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Fade-in logo
            FadeTransition(
              opacity: _logoFade,
              child: SizedBox(
                width: 400,
                height: 400,
                child: Image.asset(
                  'assets/Oyaura_Logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Quote under logo
            FadeTransition(
              opacity: _logoFade,
              child: Text(
                'Wellness begins with awareness.',
                style: GoogleFonts.lora(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFFDC143C),
                ),
              ),
            ),
            const SizedBox(height: 40),

            FadeTransition(
              opacity: _buttonFade,
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFE5E5), // ✅ Soft pink background
                      foregroundColor: const Color(0xFFFFA4A4), // ✅ Crimson-pink text
                      side: const BorderSide(color: Color(0xFFFFA4A4), width: 2), // ✅ Matching border
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFFFA4A4),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFFFA4A4), // 🔧 Sign-Up button text
                      side: const BorderSide(color: Color(0xFFFFA4A4)), // 🔧 Sign-Up border
                      padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Sign-Up',
                      style:  GoogleFonts.playfairDisplay(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}