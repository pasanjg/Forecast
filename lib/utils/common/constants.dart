import 'package:flutter/material.dart';

// Colors
const defaultFontColor = Colors.white;
const canvasColor = Color(0xFF141414);
const dayThemeAccentColor = Color(0XFF21C8F6);
const dayThemePrimaryColor = Color(0xFF637BFF);
const eveningThemeAccentColor = Color(0XFFCF5C36);
const eveningThemePrimaryColor = Color(0XFF160F29);
const nightThemeAccentColor = Color(0xFF011526);
const nightThemePrimaryColor = Color(0xFF024873);

// Text Style
const AppTextTheme = TextTheme(
  title: TextStyle(color: defaultFontColor),
  subhead: TextStyle(color: defaultFontColor),
  subtitle: TextStyle(color: defaultFontColor),
  body1: TextStyle(color: defaultFontColor),
  body2: TextStyle(color: defaultFontColor),
);

const MainTextStyle = TextStyle(
  height: 1.0,
  fontSize: 50.0,
);

const HeadingTextStyle = TextStyle(
  fontSize: 28,
  height: 1.0,
  letterSpacing: 1.0,
  fontWeight: FontWeight.bold,
);

const TitleTextStyle = TextStyle(
  fontSize: 22,
  letterSpacing: 1.0,
  fontWeight: FontWeight.w500,
);

const MediumTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
);

const RegularTextStyle = TextStyle(
  fontSize: 18.0,
  height: 1.0,
);

const SmallTextStyle = TextStyle(
  fontSize: 14.0,
  height: 1.0,
);

// Firestore

const usersCollection = "users";
const userSavedLocations = "savedLocations";
