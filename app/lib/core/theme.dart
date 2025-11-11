import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AydaColors {
  const AydaColors._();

  static const Color primary = Color(0xFF3A60C0);
  static const Color secondary = Color(0xFF6BB89D);
  static const Color accent = Color(0xFFFF857A);
  static const Color background = Color(0xFFF9F9F6);
  static const Color text = Color(0xFF2D3748);
  static const Color success = Color(0xFF1FAA59);
  static const Color warning = Color(0xFFFFB547);
  static const Color error = Color(0xFFE04747);
  static const Color info = Color(0xFF66B2FF);
}

class AydaTheme {
  const AydaTheme._();

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.interTextTheme();
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AydaColors.primary,
        onPrimary: Colors.white,
        secondary: AydaColors.secondary,
        onSecondary: Colors.white,
        error: AydaColors.error,
        onError: Colors.white,
        background: AydaColors.background,
        onBackground: AydaColors.text,
        surface: Colors.white,
        onSurface: AydaColors.text,
      ),
      scaffoldBackgroundColor: AydaColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AydaColors.background,
        foregroundColor: AydaColors.text,
        elevation: 0,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AydaColors.text,
        ),
      ),
      textTheme: baseTextTheme.copyWith(
        headlineLarge: GoogleFonts.dmSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AydaColors.text,
        ),
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AydaColors.text,
        ),
        headlineSmall: GoogleFonts.dmSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AydaColors.text,
        ),
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 18,
          color: AydaColors.text,
        ),
        bodyMedium: baseTextTheme.bodyMedium?.copyWith(
          fontSize: 16,
          color: AydaColors.text,
        ),
        bodySmall: baseTextTheme.bodySmall?.copyWith(
          fontSize: 14,
          color: AydaColors.text.withOpacity(0.7),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AydaColors.primary,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AydaColors.secondary.withOpacity(0.15),
        labelStyle: (baseTextTheme.labelMedium ?? const TextStyle()).copyWith(
          color: AydaColors.secondary.darken(0.25),
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}

extension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
