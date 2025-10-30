import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String lottiePath;
  final Color backgroundColor;
  final Color primaryColor;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.lottiePath,
    required this.backgroundColor,
    required this.primaryColor,
  });

  // Static method to get all onboarding pages
  static List<OnboardingModel> getOnboardingPages() {
    return [
      OnboardingModel(
        title: "Welcome to Hidden Treasures",
        description:
            "An app that guides incoming tourists in Egypt to landmarks, restaurants and transportation options based on their budget.",
        lottiePath: "assets/lottie/Traveler.json",
        backgroundColor: Color(0xFFF8F9FA),
        primaryColor: Color(0xFFFF6B6B),
      ),
      OnboardingModel(
        title: "Classify & Discover",
        description:
            "Easily classify and discover tourist spots, restaurants, and transportation and plan your trips with ease.",
        lottiePath: "assets/lottie/Classify & Discover.json",
        backgroundColor: Color(0xFFE0F7FA),
        primaryColor: Color(0xFF00BCD4),
      ),
      OnboardingModel(
        title: "Stay Connected",
        description:
            "Connect with other travelers, share experiences, and get real-time updates on your journey.",
        lottiePath: "assets/lottie/Messages App scene.json",
        backgroundColor: Color(0xFFFFFFFF),
        primaryColor: Color(0xFF4A90E2),
      ),
      OnboardingModel(
        title: "Let's Get Started!",
        description:
            "Embark on your adventure with Hidden Treasures and explore the wonders of Egypt like never before.",
        lottiePath: "assets/lottie/Hello Color Orange.json",
        backgroundColor: Color(0xFFFFF3E0),
        primaryColor: Color(0xFFFF9800),
      ),
    ];
  }
}
