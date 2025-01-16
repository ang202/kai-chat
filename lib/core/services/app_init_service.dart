import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/repositories/local_repository.dart';
import 'package:kai_chat/core/values/app_strings.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInitService {
  static Future<void> init() async {
    SentryFlutter.init(
      (options) {
        options.dsn = FlavorConfig.sentryDsn;
        options.environment = FlavorConfig.title;
        options.tracesSampleRate = 1.0;
        options.profilesSampleRate = 1.0;
      },
    );
    await clearSecureStorageOnReinstall();
    await checkLocale();
  }

  static Future<void> clearSecureStorageOnReinstall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const FlutterSecureStorage secureStorageInstance = FlutterSecureStorage();
    final bool isRunBefore = prefs.getBool(AppStrings.appHasRunBefore) ?? false;
    if (!isRunBefore) {
      await secureStorageInstance.deleteAll();
      await prefs.setBool(AppStrings.appHasRunBefore, true);
    }
  }

  static Future<void> checkLocale() async {
    LocalRepository localRepository = Get.find();
    Locale? currentLocale = await localRepository.getLanguage();
    if (currentLocale != null) {
      Get.updateLocale(currentLocale);
    } else {
      await localRepository.setLanguage(const Locale('en', 'US'));
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
