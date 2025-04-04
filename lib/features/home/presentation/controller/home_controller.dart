import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kai_chat/core/base/base_controller.dart';
import 'package:kai_chat/core/services/firebase_messaging_service.dart';
import 'package:kai_chat/features/home/domain/model/chat_request.dart';
import 'package:kai_chat/features/home/domain/repository/chat_repository.dart';

class HomeController extends BaseController {
  final ChatRepository chatRepository = Get.find();
  final TextEditingController textController = TextEditingController();
  final RxList<Message> messageList = <Message>[].obs;
  final listKey = GlobalKey<AnimatedListState>();

  @override
  void onInit() {
    Get.put(FirebaseMessagingService(), permanent: true);
    super.onInit();
  }

  Future<void> sendChat() async {
    final message = textController.text;
    if (message.isNotEmpty) {
      textController.clear();
      messageList.add(Message(role: "user", content: message));
      listKey.currentState?.insertItem(0);
      setLoading();
      await chatRepository.sendChat(
          chatRequest:
              ChatRequest(model: "gpt-3.5-turbo", messages: messageList),
          onSuccess: (value) {
            setSuccess();
            messageList.add(value!.choices!.first.message!);
            listKey.currentState?.insertItem(0);
          },
          onError: (err) => setError(err));
    }
  }
}
