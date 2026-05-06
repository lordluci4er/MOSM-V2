import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.black,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      elevation: 0,
    ),

    cardColor: AppColors.card,

    dividerColor: AppColors.border,

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.grey),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}