import 'package:kai_chat/features/home/domain/model/chat_request.dart';

class ChatResponse {
  String? id;
  String? object;
  int? created;
  String? model;
  List<Choice>? choices;
  Usage? usage;
  dynamic systemFingerprint;

  ChatResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
    this.systemFingerprint,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) => ChatResponse(
        id: json["id"],
        object: json["object"],
        created: json["created"],
        model: json["model"],
        choices: json["choices"] == null
            ? []
            : List<Choice>.from(
                json["choices"]!.map((x) => Choice.fromJson(x))),
        usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
        systemFingerprint: json["system_fingerprint"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "created": created,
        "model": model,
        "choices": choices == null
            ? []
            : List<dynamic>.from(choices!.map((x) => x.toJson())),
        "usage": usage?.toJson(),
        "system_fingerprint": systemFingerprint,
      };
}

class Choice {
  int? index;
  Message? message;
  dynamic logprobs;
  String? finishReason;

  Choice({
    this.index,
    this.message,
    this.logprobs,
    this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        index: json["index"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
        logprobs: json["logprobs"],
        finishReason: json["finish_reason"],
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "message": message?.toJson(),
        "logprobs": logprobs,
        "finish_reason": finishReason,
      };
}

class Usage {
  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: json["prompt_tokens"],
        completionTokens: json["completion_tokens"],
        totalTokens: json["total_tokens"],
      );

  Map<String, dynamic> toJson() => {
        "prompt_tokens": promptTokens,
        "completion_tokens": completionTokens,
        "total_tokens": totalTokens,
      };
}
