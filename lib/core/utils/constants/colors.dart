import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primaryColor = Color(0xFFF9FAFB);
  static const Color primary = Color(0xFF1E3A5F);
  static const Color secondary = Color(0xFFFEC601);
  static const Color accent = Color(0xFF89A7FF);

  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [Color(0xFFFF9A9E), Color(0xFFFAD0C4), Color(0xFFFAD0C4)],
  );

  static const Gradient splashlinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1E7B1E), Color(0xFF000000)],
  );

  static const Color textPrimary = Color(
    0xFF174D31,
  ); // Darker shade for better readability
  static const Color textSecondary = Color(
    0xFF878788,
  ); // Neutral grey for secondary text
  static const Color textWhite = Colors.white;
  static const Color textThird = Color(0xff333333);

  //button color
  static const Color buttonColor = Color(0xff37B874);
  static const Color otpbg = Color(0xffE5E6EB);

  // Background Colors
  static const Color backgroundLight = Color(
    0xFFF9FAFB,
  ); // Light neutral for clean look
  static const Color backgroundDark = Color(
    0xFF121212,
  ); // Dark background for contrast in dark mode
  static const Color primaryBackground = Color(
    0xFFF6F6F7,
  ); // Pure white for primary content areas

  // Surface Colors
  static const Color surfaceLight = Color(
    0xFFE0E0E0,
  ); // Light grey for elevated surfaces
  static const Color surfaceDark = Color(
    0xFF2C2C2C,
  ); // Dark grey for elevated surfaces in dark mode

  // Container Colors
  static const Color lightContainer = Color(
    0xFFF1F8E9,
  ); // Soft green for a subtle highlight

  // Utility Colors
  static const Color success = Color(0xFF4CAF50); // Green for success messages
  static const Color warning = Color(0xFFFFA726); // Orange for warnings
  static const Color error = Color(0xFFF44336); // Red for error messages
  static const Color info = Color(
    0xFF29B6F6,
  ); // Blue for informational messages
}
