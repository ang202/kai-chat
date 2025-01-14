import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_text_style.dart';

class SnackBarTemplate extends GetSnackBar {
  SnackBarTemplate({
    super.key,
    Color backgroundColor = AppColors.red600,
    required String message,
  }) : super(
          borderWidth: 0,
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 500),
          borderRadius: 10,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(20),
          messageText: Text(
            message,
            style: MyTextStyle.s.c(AppColors.white),
          ),
        );
}

class BaseSnackBar {
  static show({
    Color backgroundColor = AppColors.red600,
    required String message,
  }) {
    Get.showSnackbar(
        SnackBarTemplate(message: message, backgroundColor: backgroundColor));
  }
}
