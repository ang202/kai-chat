import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/base/base_binding.dart';
import 'package:kai_chat/core/routes/app_pages.dart';
import 'package:kai_chat/core/utils/app_translations.dart';
import 'package:kai_chat/core/values/app_strings.dart';
import 'package:kai_chat/core/values/app_theme.dart';
import 'package:kai_chat/features/splash/presentation/view/splash_view.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void mainGlobal() async {
  dotenv.load(fileName: FlavorConfig.fileName);
  await clearSecureStorageOnReinstall();
  SentryFlutter.init(
    (options) {
      options.dsn = FlavorConfig.sentryDsn;
      options.environment = FlavorConfig.title;
      options.tracesSampleRate = 1.0;
      options.profilesSampleRate = 1.0;
    },
  );
  // Trigger check Locale
  // RaspService.triggerRasp();
  runApp(const MyApp());
}

Future<void> clearSecureStorageOnReinstall() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const FlutterSecureStorage secureStorageInstance = FlutterSecureStorage();
  final bool isRunBefore = prefs.getBool(AppStrings.appHasRunBefore) ?? false;
  if (!isRunBefore) {
    await secureStorageInstance.deleteAll();
    await prefs.setBool(AppStrings.appHasRunBefore, true);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      locale: Get.locale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: BaseBinding(),
      theme: AppTheme().appTheme(),
      home: const SplashView(),
    );
  }
}
