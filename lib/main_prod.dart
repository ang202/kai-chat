import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kai_chat/config/flavor_config.dart';
import 'package:kai_chat/firebase_options.dart';
import 'package:kai_chat/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlavorConfig(flavor: Flavor.prod, name: "kai_chat");
  mainGlobal();
}
