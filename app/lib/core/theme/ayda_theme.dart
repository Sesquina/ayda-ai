import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AydaColors {
  const AydaColors._();

  static const primary = Color(0xFF3A60C0);
  static const secondary = Color(0xFF6BB89D);
  static const accent = Color(0xFFFF857A);
  static const background = Color(0xFFF9F9F6);
  static const text = Color(0xFF2D3748);
  static const surface = Colors.white;
  static const outline = Color(0xFFCBD5E1);
}

class AydaText {
  const AydaText._();

  static final h1 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AydaColors.text,
  );

  static final h2 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AydaColors.text,
  );

  static final body = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AydaColors.text,
  );

  static final caption = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AydaColors.text.withOpacity(0.7),
  );
}

class AydaTheme {
  const AydaTheme._();

  static ThemeData light() {
    final textTheme = GoogleFonts.interTextTheme(
      ThemeData.light().textTheme,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AydaColors.primary,
        onPrimary: Colors.white,
        secondary: AydaColors.secondary,
        onSecondary: Colors.white,
        error: Color(0xFFE04747),
        onError: Colors.white,
        background: AydaColors.background,
        onBackground: AydaColors.text,
        surface: AydaColors.surface,
        onSurface: AydaColors.text,
      ),
      scaffoldBackgroundColor: AydaColors.background,
      textTheme: textTheme.copyWith(
        headlineLarge: AydaText.h1.copyWith(fontSize: 32, fontWeight: FontWeight.w700),
        headlineMedium: AydaText.h1.copyWith(fontSize: 28),
        headlineSmall: AydaText.h1,
        titleLarge: AydaText.h2,
        bodyLarge: AydaText.body,
        bodyMedium: AydaText.body,
        bodySmall: AydaText.caption,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AydaColors.background,
        foregroundColor: AydaColors.text,
        elevation: 0,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AydaColors.text,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          textStyle: MaterialStateProperty.all(AydaText.body.copyWith(fontWeight: FontWeight.w600)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) => states.contains(MaterialState.disabled)
                ? AydaColors.primary.withOpacity(0.5)
                : AydaColors.primary,
          ),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          textStyle: MaterialStateProperty.all(AydaText.body.copyWith(fontWeight: FontWeight.w600)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(48)),
          side: MaterialStateProperty.all(const BorderSide(color: AydaColors.primary, width: 1.5)),
          foregroundColor: MaterialStateProperty.all(AydaColors.primary),
          textStyle: MaterialStateProperty.all(AydaText.body.copyWith(fontWeight: FontWeight.w600)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: AydaColors.surface,
        margin: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AydaColors.secondary.withOpacity(0.15),
        selectedColor: AydaColors.secondary.withOpacity(0.25),
        labelStyle: AydaText.body.copyWith(fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AydaColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AydaColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AydaColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AydaColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}
