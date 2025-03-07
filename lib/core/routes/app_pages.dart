import 'package:get/get.dart';
import 'package:kai_chat/core/routes/app_routes.dart';
import 'package:kai_chat/features/chat/presentation/binding/chat_binding.dart';
import 'package:kai_chat/features/chat/presentation/views/chat_view.dart';
import 'package:kai_chat/features/home/presentation/binding/home_binding.dart';
import 'package:kai_chat/features/home/presentation/views/home_view.dart';
import 'package:kai_chat/features/splash/presentation/binding/splash_binding.dart';
import 'package:kai_chat/features/splash/presentation/view/splash_view.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.main;

  static final routes = [
    GetPage(
      name: Routes.main,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
  ];
}
