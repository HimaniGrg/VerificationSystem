import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:verificationsystem/app_export.dart';

/// Helper class for managing themes and colors of application
class ThemeHelper {
  static String _appTheme = "primary";

  //Map of custom color and color schemes used in app
  static Map<String, PrimaryColors> _customColor = {
    'primary': PrimaryColors(),
  };

  static Map<String, ColorScheme> _colorScheme = {
    'primary': ColorSchemes.primaryColorScheme
  };

  /// Changes the app theme to newTheme
  void changeTheme(String newTheme) {
    _appTheme = newTheme;
  }

  /// method that returns the primary colors for the current theme.
  /// retuen type: returns an instance of 'PrimaryColors' class
  PrimaryColors _getThemeColors() {
    //check if the current theme is present in the custom color map
    if (!_customColor.containsKey(_appTheme)) {
      throw Exception("$_appTheme is not found.");
    }
    //return current theme from map
    return _customColor[_appTheme] ??
        PrimaryColors(); //it return color for current theme if found in map howver return default det of colors provided by PrimaryColors class if current theme are not found.
  }

  ///method that returns the current theme data.
  ThemeData _getThemeData() {
    //throw exception to notify given theme is not found
    if (!_colorScheme.containsKey(_appTheme)) {
      throw Exception("$_appTheme is not found.");
    }
    //return theme from map
    var colorScheme = _colorScheme[_appTheme] ??
        ColorSchemes
            .primaryColorScheme; //return color scheme or defaults to 'ColorSchemes.primaryColorScheme' if not found

    //retrn an instance of ThemeData class
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme, //assign customized color scheme to the theme
      textTheme: TextThemes.textTheme(
          colorScheme), //text theme using style defined in TextThemes class
      scaffoldBackgroundColor: colorScheme.primary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(27),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: colorScheme.primary,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  /// Returns the primary colors for the current theme.
  PrimaryColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

/// Class containing the supported text theme styles.
class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 18,
          fontFamily: 'Kameron',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 14,
          fontFamily: 'Kantumruy',
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          color: appTheme.black900,
          fontSize: 20,
          fontFamily: 'Kantumruy',
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: appTheme.black900,
          fontSize: 16,
          fontFamily: 'Kantumruy',
          fontWeight: FontWeight.w700,
        ),
      );
}

/// Class containing the supported color schemes.
class ColorSchemes {
  static final primaryColorScheme = ColorScheme.light(
    // Primary colors
    primary: Color(0XE50552C6),
    secondaryContainer: Color(0XFF0A53E2),

    // On colors(text colors)
    onPrimary: Color(0XE5FFFFFF),
  );
}

/// Class containing custom colors for a primary theme.
class PrimaryColors {
  // Black
  Color get black900 => Color(0XFF000000);

  // Blue
  Color get blue800 => Color(0XFF0653C7);

  // BlueGray
  Color get blueGray100 => Color(0XFFD9D9D9);

  // Green
  Color get green800 => Color(0XFF0AAD07);
}

//methods that return current theme data and theme colors
PrimaryColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();
