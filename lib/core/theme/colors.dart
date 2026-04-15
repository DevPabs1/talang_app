import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Synced from Stitch Deep Analysis)
  static const Color primary = Color(0xFF006666); // Talang Teal
  static const Color primaryLight = Color(0xFF0DEAFC); // Bright Cyan
  static const Color accent = Color(0xFF0095E2); // Deep Blue Accent
  static const Color primaryDark = Color(0xFF134E4A); // Teal 900 for dark contrast

  // Premium Deep Zinc Palette (No Pure Black)
  static const Color deepZinc = Color(0xFF2C2F30); // Zinc 900 for headings & secondary buttons
  static const Color brandGray = Color(0xFF595C5D); // Slate 500 for secondary text
  
  // UI Palette
  static const Color background = Color(0xFFF5F6F7); // Off-White
  static const Color surface = Colors.white; 
  static const Color border = Color(0xFFABADAE); // Slate 200

  // Nebula Card Gradients (Using Stitch Colors)
  static const List<Color> nebulaGradient = [
    Color(0xFF006666),
    Color(0xFF0DEAFC),
    Color(0xFF0095E2),
  ];

  // Text Colors
  static const Color textPrimary = Color(0xFF2C2F30); // Deep Zinc
  static const Color textSecondary = Color(0xFF595C5D); // Brand Gray
  
  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);

  // Utility Neutrals
  static const Color zinc50 = Color(0xFFFAFAFA);
  static const Color zinc100 = Color(0xFFF4F4F5);
  static const Color zinc400 = Color(0xFFA1A1AA);
  static const Color zinc500 = Color(0xFF71717A);
  static const Color zinc600 = Color(0xFF52525B);
  static const Color zinc700 = Color(0xFF3F3F46);
}
