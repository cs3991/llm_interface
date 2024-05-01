import 'package:flutter/material.dart';
import 'package:flutter_markdown_selectionarea/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:ollama_dart/ollama_dart.dart';

class MessageView extends StatelessWidget {
  final Message message;

  const MessageView(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 12),
      child: Column(
        crossAxisAlignment: message.role == MessageRole.user
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            message.role != MessageRole.user ? 'Assistant' : 'You',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SelectionArea(
            child: MarkdownBody(
              extensionSet: md.ExtensionSet.gitHubFlavored,
              data: message.content,
              // selectable: true,
            ),
          ),
        ],
      ),
    );
  }
}
