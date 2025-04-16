import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);

  // Background colors
  static const Color background = Color(0xFFF5F5F5); // Replacement for Snow1
  static const Color surface = Colors.white;

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  // Accent colors
  static const Color teal = Color(0xFF009688); // Replacement for Teal1
  static const Color grey = Color(0xFF9E9E9E); // Replacement for Grey3
  static const Color black = Color(0xFF212121); // Replacement for Black3

  // Utility colors
  static const Color error = Color(0xFFB00020);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);

  // Opacity utilities
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
