import 'package:bloc/bloc.dart';
import 'package:chat_gui/llm/ollama_repository.dart';
import 'package:meta/meta.dart';
import 'package:ollama_dart/ollama_dart.dart';

part 'chat_prompt_state.dart';

class ChatPromptCubit extends Cubit<ChatPromptState> {
  final OllamaRepository repository = OllamaRepository();
  ChatPromptCubit() : super(ChatPromptReady(prompt: '', discussion: []));

  void updatePrompt(String prompt) {
    if (prompt != state.prompt) {
      emit(state.copyWith(prompt: prompt));
    }
  }

  Future<void> sendPrompt() async {
    if (state.prompt == '' || state is ChatPromptLoading) {
      return;
    }
    final prompt = state.prompt;
    final newDiscussion = state.discussion;
    newDiscussion.add(Message(
      role: MessageRole.user,
      content: prompt,
    ));
    emit(ChatPromptLoading(discussion: newDiscussion, prompt: ''));
    final response = await repository.chat(newDiscussion);
    newDiscussion.add(response);
    var newState = ChatPromptReady(
      discussion: newDiscussion,
      prompt: '',
    );
    emit(newState);
  }
}
