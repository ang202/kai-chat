import 'package:kai_chat/features/home/domain/repository/chat_repository.dart';
import 'package:kai_chat/features/home/presentation/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatRepository>(() => ChatRepository());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
