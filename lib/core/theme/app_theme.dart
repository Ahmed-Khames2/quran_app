import 'package:flutter/material.dart';

/// تعداد الثيمات المتاحة في التطبيق مع أسماء وصفية.
enum AppTheme {
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
      bodyLarge: TextStyle(
        fontSize: 16.0, 
        color: Color(0xFF212121),
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0, 
        color: Color(0xFF757575),
        fontWeight: FontWeight.normal,
      ),
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
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: Colors.white70,
        fontWeight: FontWeight.normal,
      ),
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
