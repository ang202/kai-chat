import 'package:get/get.dart';
import 'package:kai_chat/core/base/main_controller.dart';
import 'package:kai_chat/core/routes/routing.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  final RxString buildNumber = "".obs;
  final RxString version = "".obs;
  final MainController mainController = Get.find();

  @override
  void onInit() async {
    final package = await PackageInfo.fromPlatform();
    buildNumber.value = package.buildNumber;
    version.value = package.version;
    Future.delayed(const Duration(seconds: 2), () {
      mainController.authCheckCompleter.complete(true);
      Get.offAllNamed(Routes.home);
    });
    super.onInit();
  }
}
