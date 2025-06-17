import 'package:firebase_core/firebase_core.dart';
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
import 'package:kai_chat/firebase_options.dart';

// Clean app storage if applicable
// Setup app locale
// Setup Sentry
// Run App
// Trigger Firebase Messaging Registration
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
  // RaspService.triggerRasp();
  runApp(const MyApp());
}

Future<void> _initializeApp() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: FlavorConfig.fileName);
  BaseBinding().dependencies();
  await AppInitService.init();
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
