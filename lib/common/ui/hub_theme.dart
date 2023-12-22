import 'package:flutter/material.dart';

class HubTheme {
  static const Color primary = Color(0xff1E3A8A);
  static const Color onPrimary = Color(0xff7DD3FC);
  static const Color secondary = Color(0xff10B981);
  static const Color onSecondary = Color(0xFF6EE7B7);
  static const Color background = Color(0xFFF3F4F6);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColorLight: onPrimary,
      colorScheme: const ColorScheme(
        primary: primary,
        onPrimary: onPrimary,
        brightness: Brightness.light,
        background: background,
        secondary: secondary,
        onSecondary: onSecondary,
        error: Color(0xFFB00020),
        onError: Colors.white,
        onBackground: onPrimary,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: Colors.white,
      // Define button themes
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFFB923C), // Accent color
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static const hubSmallPadding = 8.0;
  static const hubMediumPadding = 16.0;
  static const hubLargePadding = 24.0;

  static const hubBorderRadius = 8.0;
}
