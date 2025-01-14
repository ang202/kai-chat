import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:kai_chat/features/chat/presentation/controller/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Chat".tr,
          style: MyTextStyle.xxxl.bold,
        ).onTap(() {
          controller.updateLocale();
        }),
        Text(
          "Notification Data:\n${controller.fcmData}",
          style: MyTextStyle.s,
        ),
      ],
    ).padding(const EdgeInsets.all(AppValues.double10)).scaffoldWrapper();
  }
}
