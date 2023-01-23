import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static const Color primary = Color(0xFFFEBE3F); // green
  static const Color secondary = Color.fromARGB(255, 252, 219, 154);

  static const Color backgroundLightGrey = Color(0xFFE5E5E5);
  static const Color backgroundNearlyWhite = Color(0xFFFEFEFE);

  // Dark Theme
  static const Color darkPrimary = Color(0xFFFEBE3F);
  static const Color darkSecondary = Color.fromARGB(255, 252, 219, 154);

  static const Color backgroundDarkGrey = Color(0xFF383838);

  static const Color errorRed = Color(0xFFFF0000);

  static const Color dividerGrey = Color(0xFFD3D3D3);
  static const Color dividerDarkGrey = Color(0xFF656565);

  static const Color nearlyWhite = Color(0xFFFEFEFE);

  static const Color lightGrey = Color(0xFFBFBFBF);

  static const Color chipBackground = Color(0xFFEEF1F3);

  static const double APPBAR_ELEVATION = 10;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.blue,
    fontFamily: 'Schyler',
    accentColor: Color(0xFFFEBE3F),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFFEBE3F),
      onPrimary: Colors.black,
      primaryContainer: backgroundLightGrey,
      onPrimaryContainer: Colors.black,
      secondaryContainer: Color(0xFFF1F8FF),
      // onSecondaryContainer: ,
      tertiaryContainer: Color(0xFFFEFEFE),
      // onTertiaryContainer: ,
      errorContainer: primary,
      onErrorContainer: Colors.white,
      shadow: lightGrey,
      secondary: secondary,
      onSecondary: Colors.white,
      error: Colors.black,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.red,
      surface: Colors.pink,
      onSurface: Colors.black12,
    ),
    scaffoldBackgroundColor: backgroundLightGrey,
    dividerTheme: const DividerThemeData(
      color: AppTheme.dividerDarkGrey,
    ),
    appBarTheme: const AppBarTheme(
      brightness: Brightness.dark,
      elevation: APPBAR_ELEVATION,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      color: primary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.yellow,
    accentColor: primary,
    fontFamily: 'Schyler',
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: backgroundDarkGrey,
      onPrimaryContainer: Colors.black,
      secondaryContainer: Color(0xFF2F2F2F),
      // onSecondaryContainer: ,
      tertiaryContainer: Color(0xFF383838),
      // onTertiaryContainer: ,
      errorContainer: Colors.black,
      onErrorContainer: lightGrey,
      shadow: Color(0xFF232323),
      secondary: Color(0xFF464646),
      onSecondary: Colors.white,
      error: Colors.black,
      onError: Colors.white,
      background: Color(0xFF3D3D3D),
      onBackground: Colors.white,
      surface: Colors.pink,
      onSurface: Colors.black12,
    ),
    scaffoldBackgroundColor: backgroundDarkGrey,
    dividerTheme: const DividerThemeData(
      color: AppTheme.dividerGrey,
    ),
    appBarTheme: const AppBarTheme(
      elevation: APPBAR_ELEVATION,
      textTheme: TextTheme(
        subtitle1: TextStyle(
          color: primary,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}
