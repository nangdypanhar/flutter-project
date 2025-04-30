import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Color(0xffFFFFFF),
    ),
    
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xff007AFF),
      secondary: Color(0xffFF6B00), 
      tertiary: Color(0xff34C759),  
    ),
  );

  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Color(0xffFFFFFF),
    ),
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.light(
      primary: Color(0xff007AFF),
      secondary: Color(0xffFF6B00), 
      tertiary: Color(0xff34C759),  
    ),
  );
}
