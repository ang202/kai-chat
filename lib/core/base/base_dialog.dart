import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';

class BaseDialog {
  static customise({
    required Widget child,
    bool dismissable = true,
    isBase = false,
    double maxWidth = 600,
    double? maxHeight,
    bool isFrosted = false,
  }) {
    Get.dialog(
        barrierDismissible: dismissable,
        BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: isFrosted ? 10.0 : 0, sigmaY: isFrosted ? 10.0 : 0),
            child: isBase
                ? child
                : child
                    .constraintsWrapper(
                        width: maxWidth, height: maxHeight, isCenter: false)
                    .dialogWrapper()));
  }
}
