import 'package:flutter/material.dart';
import 'package:kai_chat/core/values/app_colors.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.gray200,
    );
  }
}
