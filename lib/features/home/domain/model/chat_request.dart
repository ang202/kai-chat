class ChatRequest {
  String? model;
  List<Message>? messages;

  ChatRequest({
    this.model,
    this.messages,
  });

  factory ChatRequest.fromJson(Map<String, dynamic> json) => ChatRequest(
        model: json["model"],
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "messages": messages == null
            ? []
            : List<dynamic>.from(messages!.map((x) => x.toJson())),
      };
}

class Message {
  String? role;
  String? content;

  Message({
    this.role,
    this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
