import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const Color midnight = Color(0xFF020813);
  static const Color navy = Color(0xFF061A35);
  static const Color electricBlue = Color(0xFF2F8CFF);
  static const Color cyanGlow = Color(0xFF52D8FF);

  static ThemeData get premiumDark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: electricBlue,
      brightness: Brightness.dark,
      surface: const Color(0xFF07111F),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: midnight,
      fontFamily: 'SF Pro Display',
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: navy),
      dividerTheme: DividerThemeData(
        color: Colors.white.withValues(alpha: 0.08),
        thickness: 1,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Colors.white,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.1,
        ),
        headlineSmall: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: TextStyle(
          color: Color(0xFFC8D5EA),
          fontSize: 14,
          height: 1.45,
        ),
        labelLarge: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
