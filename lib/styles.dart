import 'package:flutter/material.dart';

/*
This file contains all the styles and themes used in the app.
*/

// Colors
Color kPrimaryColor = const Color(0x00AE9F84);
Color kPrimaryFixed = const Color(0xff6E6853);
Color kPrimaryLight = const Color(0xffd6cdbc);

Color kNeutral22 = const Color(0xFF36343B);
Color kNeutralVariant95 = const Color(0xFFEAEAEA);

Color kLightPrimaryContainer = const Color(0xFFD6CDBC);

Color kLightOnPrimaryContainer = const Color(0xFF796F5C);

// Fonts
TextStyle kLabelLarge = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

TextStyle kLabelSmallSecondary = TextStyle(
  color: kTheme.colorScheme.secondary,
);

TextStyle kLabelExtraSmallSecondary = TextStyle(
  color: kTheme.colorScheme.secondary,
  fontSize: 10,
);

TextStyle k28BoldPrimaryColor = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);
TextStyle k24RegularWhite = const TextStyle(
  fontSize: 24,
  color: Colors.white,
);
TextStyle k18RegularWhite = const TextStyle(
  fontSize: 18,
  color: Colors.white,
);
TextStyle k16RegularWhite = const TextStyle(
  fontSize: 16,
  color: Colors.white,
);
TextStyle k14RegularWhite = const TextStyle(
  fontSize: 14,
  color: Colors.white,
);
TextStyle k12MediumBrown = const TextStyle(
  fontSize: 12,
  color: Color(0xff6E6853),
);

// Metrics
double kDefaultSpace = 16.0;
double kContainerBorderRadius = 10.0;

// Theme
bool kIsDarkTheme = false;

ThemeData kTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: kIsDarkTheme ? Brightness.dark : Brightness.light,
  ),
);
