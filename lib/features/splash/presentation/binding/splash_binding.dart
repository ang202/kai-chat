import 'package:kai_chat/features/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Register datasource
    Get.put<SplashController>(SplashController(), permanent: true);
  }
}
