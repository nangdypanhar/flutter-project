import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ),
    
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: const Color(0xffFD2942),
    brightness: Brightness.light,
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
    ),
    useMaterial3: true,
    fontFamily: 'Poppins',
    primaryColor: const Color(0xffFD2942),
    brightness: Brightness.dark,
  );
}
