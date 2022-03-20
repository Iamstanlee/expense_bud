import 'package:flutter/material.dart';

class AppStrings {
  static const kTitle = 'Money';
  static const kPrivacyPolicyUrl =
      "https://github.com/";
  static const kFeedbackUrl =
      "mailto:gianlucadand@gmail.com?subject=Expense%20Bud%20Feedback";
}

class AppIcons {
  static String iconPath(String icon, [String? ext]) =>
      'assets/icons/$icon.${ext ?? "png"}';
}

class AppImages {
  static String imagePath(String img, [String? ext]) =>
      'assets/images/$img.${ext ?? "png"}';
  static String get logo => imagePath('logo');
}

class AppColors {
  static Color get kScaffold => const Color(0xFFFFFFFF);
  static Color get kPrimary => const Color(0xFF5ECE9A);
  static Color get kPrimary500 => const Color(0xFF059E53);
  static Color get kDark => const Color(0xFF111418);
  static Color get kError => const Color(0xFFFE1B02);
  static Color get kGrey => const Color(0xFFB7C7CD);
  static Color get kGrey200 => const Color(0xFFE2E7EF);
}
