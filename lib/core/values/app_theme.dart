import 'package:flutter/material.dart';
import 'package:kai_chat/core/values/app_colors.dart';

class AppTheme {
  final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.gray900,
    fontFamily: "DMSans",
  );
  ThemeData appTheme() {
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
          secondary: AppColors.gray600,
          primary: AppColors.gray900,
          error: AppColors.red600),
    );
  }
}
