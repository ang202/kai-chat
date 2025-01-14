import 'package:get/get.dart';
import 'package:kai_chat/features/chat/presentation/controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
