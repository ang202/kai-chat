import 'dart:ui';

import 'package:get/get.dart';
import 'package:kai_chat/core/repositories/local_repository.dart';

class MainController extends GetxController {
  final LocalRepository localRepository = Get.find();

  // Handle overall app state
  void updateLocale() async {
    if (Get.locale == const Locale("en", "US")) {
      Get.updateLocale(const Locale('my', 'MM'));
      localRepository.setLanguage(const Locale('my', "MM"));
    } else if (Get.locale == const Locale("my", "MM")) {
      Get.updateLocale(const Locale('en', 'US'));
      localRepository.setLanguage(const Locale('en', "US"));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  void logout() {}
}
