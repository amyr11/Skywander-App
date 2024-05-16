import 'package:flutter/material.dart';

/*
This file contains all the styles and themes used in the app.
*/

// Theme
ThemeData getTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xffAE9F84),
      brightness: Brightness.light,
    ).copyWith(
      secondary: const Color(0xff6E6853),
      error: const Color(0xffB3261E),
      onPrimary: const Color(0xffFFFFFF),
      onSecondary: const Color(0xffFFFFFF),
      onSurface: const Color(0xff171716),
      onError: const Color(0xffFFFFFF),
      primaryContainer: const Color(0xffD6CDBC),
      onPrimaryFixedVariant: const Color(0xff6E6853),
    ),
  );
}

Color kNeutralVariant95 = const Color(0xffEAEAEA);

// Fonts
TextStyle kLabelLarge = const TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);

TextStyle kLabelSmallSecondary = TextStyle(
  color: getTheme().colorScheme.secondary,
);

TextStyle kLabelExtraSmallSecondary = TextStyle(
  color: getTheme().colorScheme.secondary,
  fontSize: 10,
);

TextStyle k28BoldPrimaryColor = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: getTheme().primaryColor,
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
