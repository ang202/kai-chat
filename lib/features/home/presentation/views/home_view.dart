import 'package:kai_chat/core/components/asset_image_view.dart';
import 'package:kai_chat/core/enum/view_state.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';
import 'package:kai_chat/core/values/app_assets.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:kai_chat/features/home/domain/model/chat_request.dart';
import 'package:kai_chat/features/home/presentation/controller/home_controller.dart';
import 'package:kai_chat/features/home/presentation/widgets/chat_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Widget _chatColumn({Message? message}) {
    return ChatColumn(
      message: message,
    ).padding(const EdgeInsets.only(top: AppValues.double20));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Stack(
          alignment: Alignment.center,
          children: [
            const AssetImageView(
              fileName: AppAssets.appLogoMono,
              width: AppValues.double200,
            ),
            Obx(() {
              debugPrint("${controller.messageList.length}");
              List<Message?>? messageList =
                  controller.messageList.reversed.toList();
              return Column(
                children: [
                  Expanded(
                      child: AnimatedList(
                          key: controller.listKey,
                          reverse: true,
                          initialItemCount: messageList.length,
                          itemBuilder: (context, index, animation) => index == 0
                              ? SizeTransition(
                                  sizeFactor: animation,
                                  child:
                                      _chatColumn(message: messageList[index]),
                                )
                              : _chatColumn(message: messageList[index]))),
                  controller.viewState == ViewState.loading
                      ? Column(
                          children: [
                            Row(
                              children: [
                                LoadingAnimationWidget.prograssiveDots(
                                    color: AppColors.gray400, size: 30),
                                Text(
                                  "Assistant is thinking",
                                  style: MyTextStyle.subtitle1
                                      .c(AppColors.gray600),
                                ).padding(const EdgeInsets.only(
                                    left: AppValues.double10))
                              ],
                            ).padding(const EdgeInsets.symmetric(
                                horizontal: AppValues.double20))
                          ],
                        )
                      : Container()
                ],
              );
            })
          ],
        )),
        Row(
          children: [
            Obx(() => Flexible(
                  child: TextField(
                    controller: controller.textController,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onSubmitted: (value) {
                      controller.sendChat();
                    },
                    enabled: controller.viewState != ViewState.loading,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Please enter your question",
                        hintStyle: MyTextStyle.body1.c(AppColors.gray400)),
                  ).padding(const EdgeInsets.only(left: AppValues.double10)),
                )),
            const AssetImageView(
              fileName: AppAssets.icSend,
              width: AppValues.double20,
              height: AppValues.double20,
              color: AppColors.white,
            )
                .capsulise(
                    color: AppColors.green500,
                    padding: const EdgeInsets.all(AppValues.double10))
                .onTap(() => controller.sendChat())
          ],
        ).padding(const EdgeInsets.symmetric(
            horizontal: AppValues.double10, vertical: AppValues.double5)),
      ],
    ).scaffoldWrapper(true);
  }
}
