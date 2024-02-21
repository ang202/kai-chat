import 'package:kai_chat/core/components/asset_image_view.dart';
import 'package:kai_chat/core/values/app_assets.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/features/splash/presentation/controller/splash_controller.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AssetImageView(
            fileName: AppAssets.welcomeLottie,
            height: Get.width * 0.7,
          ),
          const Text(
            "Welcome to the chat app.",
            style: MyTextStyle.h5,
          ),
          Obx(() => Text(
                "${controller.version}+${controller.buildNumber}",
                style: MyTextStyle.subtitle2.c(AppColors.gray700),
              ))
        ],
      ),
    ).scaffoldWrapper();
  }
}
