import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:kai_chat/core/enum/view_state.dart';
import 'package:kai_chat/core/values/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

extension ExpandedWidget on Widget {
  Widget padding(EdgeInsetsGeometry edge) => Padding(
        padding: edge,
        child: this,
      );

  Widget background(EdgeInsetsGeometry? padding,
          [Color? color = AppColors.gray100]) =>
      Container(
        padding: padding,
        color: color,
        child: this,
      );

  Widget onTap(VoidCallback onClick) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onClick();
        },
        child: this,
      );

  Widget capsulise(
          {EdgeInsetsGeometry? padding,
          double? radius = 100,
          Color? color = AppColors.gray900,
          bool? border = false,
          Color? borderColor = AppColors.gray200}) =>
      Container(
          padding: padding,
          decoration: BoxDecoration(
              border: border ?? true
                  ? Border.all(color: borderColor ?? AppColors.gray100)
                  : null,
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 100))),
          child: this);

  Widget roundedBorder(BorderRadius radius,
          [Color? color = AppColors.gray900]) =>
      Container(
          decoration: BoxDecoration(color: color, borderRadius: radius),
          child: this);

  Widget noSplash(BuildContext context) => Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: this);

  Widget constraintsWrapper(
          {double? width,
          double? height,
          Color? color,
          bool isCenter = true}) =>
      Container(
        color: color ?? AppColors.white,
        alignment: isCenter ? Alignment.center : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: height ?? double.infinity,
            maxWidth: width ?? double.infinity,
          ),
          child: this,
        ),
      );

  Widget dialogWrapper(
          {bool withPadding = true, EdgeInsets? customPadding}) =>
      Dialog(
          backgroundColor: AppColors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          child: padding(withPadding
              ? customPadding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
              : EdgeInsets.zero));

  Widget repaintBoundary() => RepaintBoundary(child: this);

  Widget scaffoldWrapper([bool resizeToAvoidBottomInset = false]) => Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: SafeArea(child: this),
      );

  Widget ignorePointer([bool ignore = false]) =>
      IgnorePointer(ignoring: ignore, child: this);

  Widget loading(Rx<ViewState> isLoading) => Stack(
        children: [
          this,
          Obx(() => isLoading.value == ViewState.loading
              ? Container(
                  color: AppColors.gray100.withValues(alpha: 0.6),
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                      child: LoadingAnimationWidget.hexagonDots(
                    color: AppColors.accent700,
                    size: 40,
                  ).repaintBoundary()),
                )
              : Container())
        ],
      );

  Widget expanded([int flex = 1]) => Expanded(
        flex: flex,
        child: this,
      );
}
