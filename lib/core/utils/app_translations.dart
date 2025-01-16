import 'package:get/get.dart';
import 'package:kai_chat/core/utils/en_translation.dart';
import 'package:kai_chat/core/utils/mm_translation.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'my_MM': MmTranslation.assets,
        'en_US': EnTranslation.assets,
      };
}
