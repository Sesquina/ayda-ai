import 'package:flutter/material.dart';

class AydaColors {
  static const primary = Color(0xFF3A60C0); // Serenity Indigo
  static const secondary = Color(0xFF6BB89D); // Healing Sage
  static const accent = Color(0xFFFF857A); // Coral Care
  static const background = Color(0xFFF9F9F6); // Linen White
  static const text = Color(0xFF2D3748); // Midnight Slate
}

class AydaTheme {
  static ThemeData build() {
    final base = ThemeData.light();
    return base.copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: AydaColors.primary),
      scaffoldBackgroundColor: AydaColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: AydaColors.background,
        foregroundColor: AydaColors.text,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        headlineSmall:
            TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700),
        titleLarge: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(fontFamily: 'Inter'),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AydaColors.primary,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          minimumSize: const Size.fromHeight(48),
        ),
      ),
    );
  }
}
