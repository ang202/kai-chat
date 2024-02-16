import 'dart:convert';

import 'package:kai_chat/core/extensions/api_extensions.dart';
import 'package:kai_chat/core/network/dio_client.dart';
import 'package:kai_chat/core/network/errors/failures.dart';
import 'package:kai_chat/core/values/api_constants.dart';
import 'package:kai_chat/features/home/domain/model/chat_request.dart';
import 'package:kai_chat/features/home/domain/model/chat_response.dart';
import 'package:get/get.dart';

class ChatRepository {
  final DioClient dioClient = Get.find();

  Future<void> sendChat(
      {required ChatRequest chatRequest,
      required Function(ChatResponse?) onSuccess,
      required Function(BaseFailure) onError}) async {
    await dioClient
        .post(
          ApiConstants.chatCompletions,
          body: jsonEncode(chatRequest),
          authorization: true,
        )
        .handleResponse(
          onSuccess: (value) => onSuccess.call(ChatResponse.fromJson(value)),
          onError: onError,
        );
  }
}
