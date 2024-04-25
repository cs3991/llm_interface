import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart';
import 'package:ollama_dart/ollama_dart.dart';

class MessageView extends StatelessWidget {
  final Message message;

  const MessageView(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: message.role == MessageRole.user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          message.role != MessageRole.user
              ? Text(
                  'Assistant',
                  style: Theme.of(context).textTheme.labelMedium,
                )
              : Container(),
          SelectionArea(
            child: MarkdownBody(
              data: message.content,
              // selectable: true,
            ),
          ),
        ],
      ),
    );
  }
}
