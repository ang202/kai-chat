import 'package:kai_chat/core/components/asset_image_view.dart';
import 'package:kai_chat/core/extensions/string_extensions.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';
import 'package:kai_chat/core/values/app_assets.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:kai_chat/features/home/domain/model/chat_request.dart';
import 'package:flutter/material.dart';

class ChatColumn extends StatelessWidget {
  const ChatColumn({super.key, this.message});

  final Message? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            message?.role == "assistant"
                ? const AssetImageView(
                    fileName: AppAssets.appLogo,
                    width: AppValues.double30,
                  ).padding(const EdgeInsets.only(right: AppValues.double10))
                : Text(
                    "U",
                    style: MyTextStyle.h6.c(AppColors.white),
                  )
                    .capsulise(
                        color: AppColors.green600,
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppValues.double10,
                            vertical: AppValues.double4))
                    .padding(const EdgeInsets.only(right: AppValues.double10)),
            Text(
              message?.role?.toCapitalized() ?? "",
              style: MyTextStyle.h5,
            )
          ],
        ),
        Text(
          "${message?.content}",
          style: MyTextStyle.body1.c(AppColors.gray600),
        ).padding(const EdgeInsets.only(top: AppValues.double10)),
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
