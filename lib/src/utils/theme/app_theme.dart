import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLight,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      cardColor: AppColors.cardLight,
      textTheme: const TextTheme(
        headline1: AppTextStyles.headline1,
        headline2: AppTextStyles.headline2,
        bodyText1: AppTextStyles.bodyText1,
        bodyText2: AppTextStyles.bodyText2,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryLight,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDark,
        secondary: AppColors.secondaryDark,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      cardColor: AppColors.cardDark,
      textTheme: const TextTheme(
        headline1: AppTextStyles.headline1.copyWith(color: AppColors.textDark),
        headline2: AppTextStyles.headline2.copyWith(color: AppColors.textDark),
        bodyText1: AppTextStyles.bodyText1.copyWith(color: AppColors.textDark),
        bodyText2: AppTextStyles.bodyText2.copyWith(color: AppColors.textDark),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryDark,
      ),
    );
  }
}