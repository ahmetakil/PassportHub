import 'package:flutter/material.dart';
import 'package:passport_hub/common/models/visa_requirement.dart';

part 'hub_text_theme.dart';

class HubTheme {
  static const Color primary = Color(0xff001972);
  static const Color onPrimary = Color(0xff7DD3FC);
  static const Color secondary = Color(0xff10B981);
  static const Color onSecondary = Color(0xFF6EE7B7);
  static const Color background = Color(0xFFF3F4F6);
  static const Color red = Color(0xffFF2525);
  static const Color black = Color(0xff121212);
  static const Color yellow = Color(0xffD1A564);

  static const Color blueLight = Color(0xff1D44AA);

  static const Color textFieldBackground = Color(0xCCD1D1D1);

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
        error: red,
        onError: Colors.white,
        onBackground: onPrimary,
        surface: Colors.white,
        onSurface: black,
      ),
      scaffoldBackgroundColor: const Color(0xffFAFAFA),
      // Define button themes
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFFFB923C),
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static const hubTinyPadding = 4.0;
  static const hubSmallPadding = 8.0;
  static const hubMediumPadding = 16.0;
  static const hubLargePadding = 24.0;

  static const hubBorderRadius = 8.0;
}

extension VisaRequirementTypeExtension on VisaRequirementType {
  static Color get self => HubTheme.yellow;

  Color get color {
    return switch (this) {
      VisaRequirementType.visaFree => HubTheme.primary,
      VisaRequirementType.visaOnArrival => Colors.blue,
      VisaRequirementType.eVisa => Colors.blue,
      VisaRequirementType.visaRequired => HubTheme.red,
      VisaRequirementType.noAdmission => HubTheme.red,
      VisaRequirementType.none => HubTheme.black,
    };
  }
}
