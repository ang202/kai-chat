import 'package:flutter/material.dart';

class KeyValue {
  KeyValue(
      {this.label,
      this.sublabel,
      this.id,
      this.key,
      this.isAction = false,
      this.logo,
      this.errorMessage,
      this.globalKey,
      this.widget,
      this.description,
      this.onAction,
      this.keyValueList,
      this.color,
      this.buttonText});

  String? id;
  bool? isAction = false;
  String? label;
  String? sublabel;
  String? logo;
  String? key;
  String? errorMessage;
  GlobalKey? globalKey = GlobalKey();
  Widget? widget;
  String? description;
  VoidCallback? onAction;
  List<KeyValue>? keyValueList;
  Color? color;
  String? buttonText;
}
