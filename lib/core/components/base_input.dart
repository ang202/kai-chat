import 'package:kai_chat/core/components/asset_image_view.dart';
import 'package:kai_chat/core/extensions/view_extensions.dart';
import 'package:kai_chat/core/utils/disable_emoji_formatter.dart';
import 'package:kai_chat/core/values/app_assets.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:kai_chat/core/values/app_text_style.dart';
import 'package:kai_chat/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseInput extends StatefulWidget {
  const BaseInput({
    super.key,
    this.label,
    this.isEnabled = true,
    this.hintText,
    this.onSubmit,
    this.autoFocus = false,
    this.textEditingController,
    this.labelColor = AppColors.gray900,
    this.backgroundColor = AppColors.white,
    this.validator,
    this.inputFormatters,
    this.maxLength,
    this.onChanged,
    this.disabledBorderColor,
    this.focusBorderColor,
    this.enabledBorderColor,
    this.onFocus,
    this.keyboardType,
    this.hidePasswordIcon = true,
    this.textInputAction,
    this.hintStyle,
    this.inputStyle,

    /// Controls the suffixIcon visibility. When [isObscureEnabled] is set to true, suffixIcon will be visible. By default, it is false.
    this.isPassword = false,
    this.iconPath,
    this.iconPadding,
    this.iconBgColor = AppColors.gray900,
    this.iconHeight,
    this.isPhoneNo = false,
    this.labelFontWeight,
    this.isEdit = false,
    this.isClickedEdit = false,
    this.onEdit,
    this.onCancelEdit,
  });

  final String? Function(String? value)? validator;
  final Function(String value)? onChanged;
  final Function()? onFocus;
  final bool autoFocus;
  final Color? disabledBorderColor;
  final bool hidePasswordIcon;
  final bool isPhoneNo;
  final String? hintText;
  final Color? iconBgColor;
  final String? iconPath;
  final List<TextInputFormatter>? inputFormatters;
  final bool isEnabled;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? label;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? focusBorderColor;
  final Color? enabledBorderColor;
  final int? maxLength;
  final ValueChanged? onSubmit;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final EdgeInsetsGeometry? iconPadding;
  final double? iconHeight;
  final FontWeight? labelFontWeight;
  final bool isEdit;
  final bool isClickedEdit;
  final Function()? onEdit;
  final Function()? onCancelEdit;

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  bool _passwordVisible = false;
  final FocusNode focusNode = FocusNode();
  Color _borderColor = AppColors.white;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {
        _borderColor =
            focusNode.hasFocus ? AppColors.colorAccent : AppColors.gray100;
      });
    });
  }

  Widget _suffixWidget(bool value) {
    return const AssetImageView(
      fileName: AppAssets.icObscure,
      color: AppColors.colorAccent,
    ).onTap(() {
      setState(() {
        _passwordVisible = !value;
      });
    }).padding(const EdgeInsets.only(right: 8));
  }

  Widget _prefixWidget() {
    return Padding(
      padding: widget.iconPadding ??
          const EdgeInsets.symmetric(
              horizontal: AppValues.double10, vertical: AppValues.double6),
      child: CircleAvatar(
        radius: AppValues.double18,
        backgroundColor: widget.iconBgColor,
        child: AssetImageView(
          fileName: widget.iconPath!,
          height: widget.iconHeight,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${focusNode.hasFocus}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Spacer(),
            if (widget.isEdit)
              widget.isClickedEdit
                  ? SizedBox(
                      height: AppValues.double16,
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          widget.onCancelEdit?.call();
                        },
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        splashRadius: AppValues.double16,
                        iconSize: AppValues.double23,
                        color: AppColors.red700,
                      ),
                    )
                  : SizedBox(
                      height: AppValues.double16,
                      child: IconButton(
                        alignment: Alignment.center,
                        onPressed: () {
                          widget.onEdit?.call();
                        },
                        icon: const Icon(Icons.edit),
                        padding: EdgeInsets.zero,
                        splashRadius: AppValues.double16,
                        iconSize: AppValues.double20,
                        color: AppColors.colorAccent,
                      ),
                    )
          ],
        ),
        Container(
          padding: const EdgeInsets.all(AppValues.double10),
          decoration: BoxDecoration(
            color: focusNode.hasFocus == true
                ? AppColors.white
                : AppColors.gray100,
            border: Border.all(color: _borderColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            autofocus: widget.autoFocus,
            controller: widget.textEditingController,
            validator: widget.validator,
            focusNode: focusNode,
            autocorrect: false,
            obscureText: widget.isPassword ? !_passwordVisible : false,
            style: widget.inputStyle ?? MyTextStyle.s,
            onChanged: widget.onChanged,
            onTapOutside: (event) {
              focusNode.unfocus();
            },
            maxLength: widget.maxLength,
            onTap: () {
              if (Get.isSnackbarOpen) Get.closeAllSnackbars();
              widget.onFocus?.call();
            },
            inputFormatters: [
              DisableEmojiInputFormatter(),
              if (widget.inputFormatters != null) ...widget.inputFormatters!,
            ],
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            onFieldSubmitted: (text) {
              widget.onSubmit?.call(text);
            },
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              enabled: widget.isEnabled,
              filled: false,
              hintText: widget.hintText,
              border: InputBorder.none,
              hintStyle:
                  widget.hintStyle ?? MyTextStyle.s.c(AppColors.gray400),
              errorStyle: MyTextStyle.s.c(AppColors.red600),
              labelText: widget.label ?? "",
              labelStyle: MyTextStyle.s.copyWith(
                  color: focusNode.hasFocus
                      ? AppColors.colorAccent
                      : AppColors.gray600,
                  fontWeight: widget.labelFontWeight),
              suffixIconConstraints:
                  const BoxConstraints(minHeight: 30, minWidth: 30),
              suffixIcon: !widget.hidePasswordIcon
                  ? _suffixWidget(_passwordVisible)
                  : null,
              prefixIconConstraints:
                  const BoxConstraints(minHeight: 30, minWidth: 30),
              prefixIcon: !widget.isPhoneNo
                  ? widget.iconPath != null
                      ? _prefixWidget()
                      : null
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.iconPath != null) _prefixWidget(),
                        if (widget.textEditingController?.text.isNotEmpty ==
                                true ||
                            focusNode.hasFocus)
                          Padding(
                            padding: EdgeInsets.only(
                                left: widget.iconPath != null
                                    ? AppValues.double0
                                    : AppValues.double10,
                                top: AppValues.double15,
                                right: AppValues.double5),
                            child: const Text(
                              '+60',
                              style: MyTextStyle.s,
                            ),
                          ),
                      ],
                    ),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: widget.iconPath != null
                      ? AppValues.double0
                      : AppValues.double5),
            ),
          ),
        ),
      ],
    ).repaintBoundary();
  }
}
