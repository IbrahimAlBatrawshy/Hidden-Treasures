import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hidden_treasures/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hidden_treasures/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Decide where to navigate after splash depending on whether onboarding was seen
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (!mounted) return;

    if (!seenOnboarding) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 260.0),
              child: Image.asset(
                "assets/images/logo.png",
                width: 288,
                height: 114,
              ),
            ),
          ),
          // Lottie loading animation under the logo
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Lottie.asset(
                  'assets/lottie/Loading Dots In Yellow.json',
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
