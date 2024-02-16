import 'package:kai_chat/core/routes/routing.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.home);
    });
    super.onInit();
  }
}
