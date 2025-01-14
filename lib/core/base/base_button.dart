import 'package:flutter/material.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final bool enabled;
  final bool fullWidth;
  final bool withBorder;
  final VoidCallback onClick;
  final bool isLoading;

  const BaseButton({
    super.key,
    required this.text,
    this.type = ButtonType.primary,
    this.enabled = true,
    this.withBorder = false,
    this.fullWidth = false,
    required this.onClick,
    this.isLoading = false,
  });

  Color getButtonColor() {
    Color backgroundColor = AppColors.gray900;
    switch (type) {
      case ButtonType.primary:
        backgroundColor = AppColors.orange700;
        break;
      case ButtonType.error:
        backgroundColor = AppColors.red600;
        break;
      case ButtonType.secondary:
        backgroundColor = AppColors.green500;
        break;
      case ButtonType.white:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.gray:
        backgroundColor = AppColors.gray100;
        break;
    }
    return backgroundColor;
  }

  Color getTextColor() {
    Color backgroundColor = AppColors.gray900;
    switch (type) {
      case ButtonType.primary:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.error:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.secondary:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.white:
        backgroundColor = AppColors.orange700;
        break;
      case ButtonType.gray:
        backgroundColor = AppColors.gray900;
        break;
    }
    return backgroundColor;
  }

  Widget _buttonBody() {
    final ButtonStyle style = ElevatedButton.styleFrom(
        side: type == ButtonType.white
            ? const BorderSide(
                width: 1.0,
                color: AppColors.gray400,
              )
            : null,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        splashFactory: InkRipple.splashFactory,
        backgroundColor: getButtonColor());

    return ElevatedButton(
        onPressed: enabled
            ? () {
                if (!isLoading) onClick();
              }
            : null,
        style: style,
        child: isLoading
            ? SizedBox(
                height: AppValues.double20,
                child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.white, size: 25))
            : Text(text.toUpperCase(),
                style: (fullWidth ? MyTextStyle.s : MyTextStyle.xxs)
                    .extraBold
                    .c(getTextColor())));
  }

  @override
  Widget build(BuildContext context) {
    return fullWidth
        ? ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            child: SizedBox(
              height: AppValues.double50,
              child: _buttonBody(),
            ))
        : SizedBox(height: AppValues.double50, child: _buttonBody());
  }
}

enum ButtonType { primary, secondary, white, gray, error }
