import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verificationsystem/app_export.dart';

class CustomTextStyles {
  static ThemeData get theme => ThemeData();

  static double get fSize => 16.0;

  // Body text style
  static get bodyLargeKantumruy => GoogleFonts.kantumruy(
        textStyle: theme.textTheme.bodyText1!.copyWith(fontSize: fSize),
      );

  static get bodyLargeOnPrimary => GoogleFonts.kantumruy(
        textStyle: theme.textTheme.bodyText1!.copyWith(
          color: theme.colorScheme.onPrimary.withOpacity(1),
        ),
      );

  static get bodyMediumSecondaryContainer => GoogleFonts.kantumruy(
        textStyle: theme.textTheme.bodyText2!.copyWith(
          color: theme.colorScheme.secondaryContainer,
        ),
      );

  // Title text style
  static get titleLargeKameron => GoogleFonts.kameron(
        textStyle: theme.textTheme.headline1!.copyWith(
          fontWeight: FontWeight.w400,
        ),
      );

  static get titleLargeKameronOnPrimary => GoogleFonts.kameron(
        textStyle: theme.textTheme.headline1!.copyWith(
          color: theme.colorScheme.onPrimary.withOpacity(1),
          fontWeight: FontWeight.w400,
        ),
      );
}

extension on TextStyle {
  TextStyle get kantumruy {
    return copyWith(
      fontFamily: 'Kantumruy',
    );
  }

  TextStyle get kameron {
    return copyWith(
      fontFamily: 'Kameron',
    );
  }
}
