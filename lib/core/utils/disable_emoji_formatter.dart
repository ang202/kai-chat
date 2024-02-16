import 'package:kai_chat/core/values/reg_exp_values.dart';
import 'package:flutter/services.dart';

class DisableEmojiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // You can use any method to check if newValue.text contains emojis.
    // Here, we're using a simple regex pattern to check for common emojis.
    // Feel free to customize this pattern based on your needs.

    if (RegExpValues.emoji.hasMatch(newValue.text)) {
      // If the newValue contains emojis, revert to the oldValue.
      return oldValue;
    }

    // Otherwise, allow the input.
    return newValue;
  }
}
