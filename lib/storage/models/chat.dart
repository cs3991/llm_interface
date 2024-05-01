import 'package:ollama_dart/ollama_dart.dart';

class Chat {
  String? id;
  final List<Message> messages;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String title;
  final bool isArchived;

  Chat({
    this.id,
    required this.messages,
    required this.createdTime,
    required this.updatedTime,
    required this.title,
    required this.isArchived,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'messages': messages.map((message) => message.toJson()).toList(),
      'createdTime': createdTime.toIso8601String(),
      'updatedTime': updatedTime.toIso8601String(),
      'title': title,
      'isArchived': isArchived,
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    String? id = json['id'];
    List<Message> messages = (json['messages'] as List<dynamic>)
        .map((messageJson) => Message.fromJson(messageJson))
        .toList();
    DateTime createdTime = DateTime.parse(json['createdTime']);
    DateTime updatedTime = DateTime.parse(json['updatedTime']);
    String title = json['title'];
    bool isArchived = json['isArchived'];

    return Chat(
      id: id,
      messages: messages,
      createdTime: createdTime,
      updatedTime: updatedTime,
      title: title,
      isArchived: isArchived,
    );
  }
}
