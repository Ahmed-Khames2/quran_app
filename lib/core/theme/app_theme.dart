import 'package:flutter/material.dart';

/// تعداد الثيمات المتاحة في التطبيق مع أسماء وصفية.
enum AppTheme {
  // blueLight("Blue Light"),
  // redDark("Red Dark");
  islamicLight("Islamic Light"),
  islamicDark("Islamic Dark");

  const AppTheme(this.name);
  final String name;
}

/// بيانات الثيم لكل قيمة من AppTheme.
final appThemeData = {
  AppTheme.islamicLight: ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    primaryColor: const Color(0xFF006754),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF006754),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF212121)),
      titleLarge: TextStyle(color: Color(0xFF006754)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF87D1A4),
        foregroundColor: Colors.white,
      ),
    ),
    cardColor: Colors.white,
  ),

  AppTheme.islamicDark: ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    primaryColor: const Color(0xFF1A3C40),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1A3C40),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Color(0xFF4ECDC4)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4ECDC4),
        foregroundColor: Colors.black,
      ),
    ),
    cardColor: const Color(0xFF1E1E1E),
  ),
};
