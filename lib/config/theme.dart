import 'package:expense_tracker/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get _baseTheme => ThemeData(
      primaryColor: AppColors.kPrimary,
      scaffoldBackgroundColor: AppColors.kScaffold,
      fontFamily: Fonts.kPrimary,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          primary: AppColors.kPrimary,
          onPrimary: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.kScaffold,
        unselectedItemColor: AppColors.kGrey,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      iconTheme: IconThemeData(
        color: AppColors.kGrey,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.kPrimary,
      ));

  static ThemeData get defaultTheme =>
      _baseTheme.copyWith(brightness: Brightness.light);
}

class Fonts {
  static const kPrimary = "SpaceGrotesk";
}

class Insets {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 32;
}

class Corners {
  static const Radius smRadius = Radius.circular(Insets.sm);
  static const BorderRadius smBorder = BorderRadius.all(smRadius);

  static const Radius mdRadius = Radius.circular(Insets.md);
  static const BorderRadius mdBorder = BorderRadius.all(mdRadius);

  static const Radius lgRadius = Radius.circular(Insets.lg);
  static const BorderRadius lgBorder = BorderRadius.all(lgRadius);

  static const Radius xlRadius = Radius.circular(50);
  static const BorderRadius xlBorder = BorderRadius.all(xlRadius);
}

class FontSizes {
  static const double s8 = 8;
  static const double s10 = 10;
  static const double s12 = 12;
  static const double s14 = 14;
  static const double s16 = 16;
  static const double s18 = 18;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s36 = 36;
  static const double s48 = 48;
}

class IconSizes {
  static const double sm = 18;
  static const double md = 24;
  static const double lg = 32;
}
