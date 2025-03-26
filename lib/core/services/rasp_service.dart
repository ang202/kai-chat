import 'package:flutter/material.dart';
import 'package:freerasp/freerasp.dart';

class RaspService {
  static void triggerToast({String? error}) {
    debugPrint("Rasp Error: $error");
  }

  static Future<void> triggerRasp() async {
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
}
