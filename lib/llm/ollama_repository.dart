import 'package:ollama_dart/ollama_dart.dart';

class OllamaRepository {
  static const baseUrl = 'http://localhost:11434/api';
  final OllamaClient ollamaClient = OllamaClient(baseUrl: baseUrl);

  Future<Message> chat(List<Message> messages) async {
    var response = await ollamaClient.generateChatCompletion(
      request:
          GenerateChatCompletionRequest(model: 'llama3', messages: messages),
    );
    if (response.message == null) {
      throw Exception('Message is null');
    }
    return response.message!;
  }
}
