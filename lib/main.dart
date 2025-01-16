import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/base/base_binding.dart';
import 'package:kai_chat/core/routes/app_pages.dart';
import 'package:kai_chat/core/services/app_init_service.dart';
import 'package:kai_chat/core/utils/app_translations.dart';
import 'package:kai_chat/core/values/app_theme.dart';
import 'package:kai_chat/features/splash/presentation/view/splash_view.dart';

// Clean app storage if applicable
// Setup app locale
// Setup Sentry
// Run App
// Trigger Firebase Messaging Registration
void mainGlobal() async {
  BaseBinding().dependencies();
  dotenv.load(fileName: FlavorConfig.fileName);
  await AppInitService.init();
  // RaspService.triggerRasp();
  runApp(const MyApp());
}

void checkAppLocale() {}

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
      theme: AppTheme().appTheme(),
      home: const SplashView(),
    );
  }
}
