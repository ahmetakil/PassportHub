import 'package:flutter/material.dart';

const Color primary = Color(0xff1E3A8A);
const Color onPrimary = Color(0xff7DD3FC);
const Color secondary = Color(0xff10B981);
const Color onSecondary = Color(0xFF6EE7B7);
const Color background = Color(0xFFF3F4F6);
const Color onBackground = Color(0xFF4B5563);

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColorLight: onPrimary,
      colorScheme: ColorScheme(
        primary: primary,
        onPrimary: onPrimary,
        brightness: Brightness.light,
        background: background,
        secondary: secondary,
        onSecondary: onSecondary,
        error: Color(0xFFB00020),
        onError: Colors.white,
        onBackground: onBackground,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: Color(0xFF4B5563),
      // Define button themes
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFFFB923C), // Accent color
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}

ThemeData fennelThemeLight = ThemeData(
  brightness: Brightness.light,
  primaryColor: primary,
);
