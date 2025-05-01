import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1C1C1E),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: Color(0xFFFFFFFF),
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: Color(0xFF007AFF),
    brightness: Brightness.light,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1C1C1E), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
    ),
    colorScheme: ColorScheme.light(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFF34C759),
      tertiary: Color(0xFFFF9500),
      surface: Color(0xFFF2F2F7),
      background: Color(0xFFFFFFFF),
      onPrimary: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1C1C1E),
      outline: Color(0xFFD1D1D6),
    ),
  );
}
