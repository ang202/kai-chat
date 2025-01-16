import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_values.dart';

class BaseBottomSheet {
  static void show({
    required Widget child,
    bool? isScrollControlled = false,
    bool? isDismissible = true,
  }) {
    Get.bottomSheet(
      Container(
          padding: const EdgeInsets.only(top: AppValues.double2),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SafeArea(
            child: child,
          )),
      isScrollControlled: isScrollControlled ?? false,
      isDismissible: isDismissible ?? true,
      enableDrag: isDismissible ?? true,
    );
  }
}
