import 'package:kai_chat/core/values/app_colors.dart';
import 'package:flutter/material.dart';

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

  Widget constraintsWrapper(double width) => Center(
          child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
        ),
        child: this,
      ));

  Widget repaintBoundary() => RepaintBoundary(child: this);

  Widget scaffoldWrapper([bool resizeToAvoidBottomInset = false]) => Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: this,
      );

  Widget ignorePointer([bool ignore = false]) =>
      IgnorePointer(ignoring: ignore, child: this);
}
