import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/base/base_controller.dart';
import 'package:kai_chat/core/base/main_controller.dart';

class ChatController extends BaseController {
  final Map<String, dynamic> fcmData = Get.arguments;
  MainController mainController = Get.find();

  @override
  void onInit() {
    debugPrint("Chat Argument $fcmData");
    super.onInit();
  }

  void updateLocale() {
    mainController.updateLocale();
  }
}
