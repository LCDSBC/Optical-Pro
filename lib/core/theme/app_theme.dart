import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const _brand = Color(0xFF53D7FF);
  static const _medicalGreen = Color(0xFF5AF5B1);
  static const _darkBackground = Color(0xFF071018);
  static const _darkSurface = Color(0xFF101C28);

  static ThemeData dark() {
    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: _brand,
      primary: _brand,
      secondary: _medicalGreen,
      surface: _darkSurface,
    );

    return _base(colorScheme).copyWith(
      scaffoldBackgroundColor: _darkBackground,
      cardTheme: _cardTheme(colorScheme),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: _darkSurface,
        indicatorColor: _brand.withValues(alpha: 0.16),
        selectedIconTheme: const IconThemeData(color: _brand),
        selectedLabelTextStyle: const TextStyle(
          color: _brand,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _brand,
      secondary: _medicalGreen,
    );
    return _base(colorScheme);
  }

  static ThemeData _base(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  static CardThemeData _cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      color: colorScheme.surface.withValues(alpha: 0.82),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: colorScheme.outlineVariant.withValues(alpha: 0.28),
        ),
      ),
    );
  }
}
