part of 'chat_prompt_cubit.dart';

@immutable
sealed class ChatPromptState {
  final String prompt;
  final List<Message> discussion;
  const ChatPromptState({required this.discussion, required this.prompt});

  ChatPromptState copyWith({String? prompt, List<Message>? discussion});
}

final class ChatPromptReady extends ChatPromptState {
  const ChatPromptReady({required super.discussion, required super.prompt});

  @override
  ChatPromptReady copyWith({String? prompt, List<Message>? discussion}) {
    return ChatPromptReady(
      prompt: prompt ?? this.prompt,
      discussion: discussion ?? this.discussion,
    );
  }
}

final class ChatPromptLoading extends ChatPromptState {
  const ChatPromptLoading({required super.discussion, required super.prompt});

  @override
  ChatPromptLoading copyWith({String? prompt, List<Message>? discussion}) {
    return ChatPromptLoading(
      prompt: prompt ?? this.prompt,
      discussion: discussion ?? this.discussion,
    );
  }
}
