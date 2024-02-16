import 'package:kai_chat/core/values/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.accent500,
    fontFamily: "DMSans",
  );
  ThemeData appTheme() {
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
          secondary: AppColors.gray600,
          primary: AppColors.accent500,
          error: AppColors.red600),
    );
  }
}
