import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/base/base_controller.dart';

class ChatController extends BaseController {
  final Map<String, dynamic> fcmData = Get.arguments;

  @override
  void onInit() {
    debugPrint("Chat Argument $fcmData");
    super.onInit();
  }

  void updateLocale() async {
    if (Get.locale == const Locale("en", "US")) {
      Get.updateLocale(const Locale('ko', 'KR'));
    } else if (Get.locale == const Locale("ko", "KR")) {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
