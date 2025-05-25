import 'package:flutter/material.dart';

/// App theme configuration
class AppTheme {
  // Colors
  static const Color primaryColor = Colors.black;
  static const Color accentColor = Color(0x00d49f07);
  static const Color backgroundColor = Colors.white;
  static const Color buttonColor = Color.fromRGBO(255, 232, 178, 1);
  static const Color cardColor = Color(0x0000000D);
  static const Color errorColor = Color(0xFFE53935);
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textFieldColor = Color.fromRGBO(238, 240, 245, 1);

  // Text Theme
  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.bold,
      fontSize: 22,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),

    bodyLarge: TextStyle(fontFamily: 'Urbanist', fontSize: 16),
    bodyMedium: TextStyle(fontFamily: 'Urbanist', fontSize: 14),
    bodySmall: TextStyle(fontFamily: 'Urbanist', fontSize: 12),
    labelLarge: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Urbanist',
      fontWeight: FontWeight.w500,
      fontSize: 10,
    ),
  );

  // Light theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Urbanist',
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
      tertiary: buttonColor,
      error: errorColor,
      surface: backgroundColor,
    ),
    textTheme: textTheme,
    scaffoldBackgroundColor: backgroundColor,
    cardTheme: const CardTheme(
      color: cardColor,
      elevation: 2,
      margin: EdgeInsets.all(8),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: textFieldColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    badgeTheme: const BadgeThemeData(backgroundColor: buttonColor),
  );
}
