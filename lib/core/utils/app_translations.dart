import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'greeting': '안녕하세요',
          'Chat': '채팅',
        },
        'ja_JP': {
          'greeting': 'こんにちは',
          'Chat': 'チャット',
        },
        'en_US': {
          'greeting': 'Hello',
          'Chat': 'Chat',
        },
      };
}
