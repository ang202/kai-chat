import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freerasp/freerasp.dart';
import 'package:get/get.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/core/base/base_binding.dart';
import 'package:kai_chat/core/routes/app_pages.dart';
import 'package:kai_chat/core/utils/app_translations.dart';
import 'package:kai_chat/core/values/app_theme.dart';
import 'package:kai_chat/features/splash/presentation/view/splash_view.dart';

void mainGlobal() async {
  dotenv.load(fileName: FlavorConfig.fileName);
  // await triggerRasp();
  runApp(const MyApp());
}

void triggerToast({String? error}) {
  Fluttertoast.showToast(
      msg: error ?? "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<void> triggerRasp() async {
  final config = TalsecConfig(
    /// For Android
    androidConfig: AndroidConfig(
      packageName: 'com.kai.chat',
      signingCertHashes: ['7BHB18WtEfIQa7ZdYPoUjpDOub6HE23TM87nsQ2JMfI='],
      supportedStores: ['com.sec.android.app.samsungapps'],
    ),

    /// For iOS
    iosConfig: IOSConfig(
      bundleIds: ['com.kai.chat.ios'],
      teamId: 'asd',
    ),
    watcherMail: 'kt.ang@neurogine.com',
    isProd: true,
  );
  await Talsec.instance.start(config);
  final callback = ThreatCallback(
      onAppIntegrity: () => {
            triggerToast(error: "App Integrity"),
            debugPrint("App integrity"),
          },
      onObfuscationIssues: () => {
            triggerToast(error: "Obfuscation issues"),
            debugPrint("Obfuscation issues")
          },
      onDebug: () => {
            triggerToast(error: "Debugging"),
            debugPrint("Debugging"),
          },
      onDeviceBinding: () => debugPrint("Device binding"),
      onDeviceID: () => debugPrint("Device ID"),
      onHooks: () => debugPrint("Hooks"),
      onPasscode: () => debugPrint("Passcode not set"),
      onPrivilegedAccess: () => debugPrint("Privileged access"),
      onSecureHardwareNotAvailable: () => {
            triggerToast(error: "Secure hardware not available"),
            debugPrint("Secure hardware not available")
          },
      onSimulator: () => {
            triggerToast(error: "Simulator"),
            debugPrint("Simulator"),
          },
      onUnofficialStore: () => {
            triggerToast(error: "Unofficial store"),
            debugPrint("Unofficial store"),
          });

  // Attaching listener
  Talsec.instance.attachListener(callback);
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
