import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors (Black)
  static const Color primary = Color(0xFF000000); // Black
  static const Color primaryAccent = Color(0xFF424242); // Dark Grey
  static const Color primaryLight = Color(0xFF757575); // Medium Grey

  // Secondary Colors (Orange)
  static const Color secondary = Color(0xFFFF8C00); // Orange
  static const Color secondaryAccent = Color(0xFFE65100); // Dark Orange
  static const Color secondaryLight = Color(0xFFFFB366); // Light Orange

  // Background Colors
  static const Color background = Color(0xFFFFFFFF); // White
  static const Color backgroundSecondary = Color(0xFFF5F5F5); // Light Grey
  static const Color backgroundDark = Color(0xFF000000); // Black

  // Text Colors
  static const Color textPrimary = Color(0xFF000000); // Black
  static const Color textSecondary = Color(0xFF757575); // Medium Grey
  static const Color textLight = Color(0xFF9E9E9E); // Light Grey
  static const Color textWhite = Color(0xFFFFFFFF); // White

  // Accent Colors
  static const Color accent = Color(0xFFFF6B35); // Vibrant Orange
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF8C00); // Orange
  static const Color error = Color(0xFFF44336); // Red
  static const Color info = Color(0xFF000000); // Black

  // Rating Colors
  static const Color star = Color(0xFFFF8C00); // Orange Star
  static const Color starUnfilled = Color(0xFFE0E0E0); // Light Grey

  // Favorite Colors
  static const Color favorite = Color(0xFFF44336); // Red
  static const Color favoriteUnfilled = Color(0xFF9E9E9E); // Grey

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000); // 10% Black
  static const Color shadowMedium = Color(0x33000000); // 20% Black
  static const Color shadowDark = Color(0x4D000000); // 30% Black

  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0); // Light Grey
  static const Color borderMedium = Color(0xFFBDBDBD); // Medium Grey
  static const Color borderDark = Color(0xFF757575); // Dark Grey

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF000000), Color(0xFF424242)], // Black to Dark Grey
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF8C00), Color(0xFFE65100)], // Orange to Dark Orange
  );

  static const LinearGradient blackOrangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF000000), Color(0xFFFF8C00)], // Black to Orange
  );

  static const LinearGradient overlayGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Color(0xB3000000)], // 70% Black
  );

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF); // White
  static const Color cardShadow = Color(0x1A000000); // 10% Black

  // Button Colors
  static const Color buttonPrimary = Color(0xFFFF8C00); // Orange
  static const Color buttonSecondary = Color(0xFF000000); // Black
  static const Color buttonDisabled = Color(0xFFE0E0E0); // Light Grey

  // Status Colors
  static const Color online = Color(0xFF4CAF50); // Green
  static const Color offline = Color(0xFF9E9E9E); // Grey
  static const Color busy = Color(0xFFFF8C00); // Orange
}