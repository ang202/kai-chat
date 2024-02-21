import 'package:kai_chat/core/routes/routing.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController {
  final RxString buildNumber = "".obs;
  final RxString version = "".obs;

  @override
  void onInit() async {
    final package = await PackageInfo.fromPlatform();
    buildNumber.value = package.buildNumber;
    version.value = package.version;
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.home);
    });
    super.onInit();
  }
}
