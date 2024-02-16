import 'package:flutter/material.dart';

class BaseTextStyle extends TextStyle {
  const BaseTextStyle({
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    String fontFamily = 'DMSans',
    TextDecoration decoration = TextDecoration.none,
  }) : super(
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 16.0,
          height: height ?? 1.5,
          leadingDistribution: TextLeadingDistribution.even,
          decoration: decoration,
          fontFamily: fontFamily,
        );
}

class MyTextStyle {
  static const FontWeight fontWeight = FontWeight.w600;

  static const TextStyle xl5 = BaseTextStyle(
    fontSize: 42,
    fontWeight: fontWeight,
  );
  static const TextStyle xl2 = BaseTextStyle(
    fontSize: 32,
    fontWeight: fontWeight,
  );
  static const TextStyle h1 = BaseTextStyle(
    fontSize: 24,
    fontWeight: fontWeight,
  );
  static const TextStyle h2 = BaseTextStyle(
    fontSize: 22,
    fontWeight: fontWeight,
  );
  static const TextStyle h3 = BaseTextStyle(
    fontSize: 20,
    fontWeight: fontWeight,
  );
  static const TextStyle h4 = BaseTextStyle(
    fontSize: 18,
    fontWeight: fontWeight,
  );
  static const TextStyle h5 = BaseTextStyle(
    fontSize: 16,
    fontWeight: fontWeight,
  );
  static const TextStyle h6 = BaseTextStyle(
    fontSize: 14,
    fontWeight: fontWeight,
  );
  static const TextStyle h7 = BaseTextStyle(
    fontSize: 12,
    fontWeight: fontWeight,
  );
  static const TextStyle body1 = BaseTextStyle(
    fontSize: 14,
  );
  static const TextStyle body2 = BaseTextStyle(
    fontSize: 16,
  );
  static const TextStyle body3 = BaseTextStyle(
    fontSize: 18,
  );
  static const TextStyle subtitle1 = BaseTextStyle(
    fontSize: 12,
  );
  static const TextStyle subtitle2 = BaseTextStyle(
    fontSize: 10,
  );
}

// Extension to help add params in TextStyle
extension TextStyleHelpers on TextStyle {
  TextStyle c(Color value) => copyWith(color: value);
  TextStyle underline() => copyWith(decoration: TextDecoration.underline);
}
