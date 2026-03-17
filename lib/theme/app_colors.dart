import 'package:flutter/material.dart';

/// Custom color palette for dark mode with red accents
class AppColors {
  // Background Colors
  static const Color primaryBg = Color(0xFF0D0D0D);      // Main app background
  static const Color secondaryBg = Color(0xFF1A1A1A);   // Cards/containers
  static const Color surfaceBg = Color(0xFF262626);     // Elevated elements

  // Red Accent System
  static const Color primaryRed = Color(0xFFEF4444);    // Buttons, key actions
  static const Color hoverRed = Color(0xFFDC2626);      // Hover/active state
  static const Color softRed = Color(0xFF7F1D1D);       // Subtle backgrounds
  static const Color subtleRed = Color(0xFFFCA5A5);     // Secondary accents

  // Text Colors (readability optimized)
  static const Color primaryText = Color(0xFFF5F5F5);   // Main text
  static const Color secondaryText = Color(0xFFA3A3A3); // Secondary text
  static const Color mutedText = Color(0xFF737373);     // Muted/disabled text

  // Additional utility colors
  static const Color divider = Color(0xFF404040);
  static const Color error = Color(0xFFEF4444);         // Same as primaryRed
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFD7E14);
}
