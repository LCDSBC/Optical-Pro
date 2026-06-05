import 'package:flutter/material.dart';

class AppTheme {
  static const Color midnight = Color(0xFF061225);
  static const Color navy = Color(0xFF0B1E3A);
  static const Color medicalBlue = Color(0xFF0EA5E9);
  static const Color clinicalCyan = Color(0xFF67E8F9);
  static const Color card = Color(0xFF10243F);

  static ThemeData get dark {
    final scheme = ColorScheme.fromSeed(
      seedColor: medicalBlue,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: midnight,
      colorScheme: scheme.copyWith(
        primary: medicalBlue,
        secondary: clinicalCyan,
        surface: card,
      ),
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        labelStyle: const TextStyle(color: Color(0xFFB9D8F5)),
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
        prefixIconColor: clinicalCyan,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: clinicalCyan, width: 1.4),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: medicalBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    );
  }
}
