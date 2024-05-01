import 'package:bloc/bloc.dart';
import 'package:chat_gui/storage/models/chat.dart';
import 'package:chat_gui/storage/repository/storage_repository.dart';
import 'package:meta/meta.dart';

part 'chat_storage_state.dart';

class ChatStorageCubit extends Cubit<ChatStorageState> {
  ChatStorageCubit() : super(const ChatStorageInitial(selected: 0));

  final repository = ChatStorageRepository();

  void changeChat(int id) {
    if (state is ChatStorageLoaded) {
      emit(ChatStorageLoaded(
          chats: (state as ChatStorageLoaded).chats, selected: id));
    }
  }

  void loadChats() async {
    emit(ChatStorageLoading(selected: state.selected));
    var chats = (await repository.getAllChats()).toList();
    chats.sort((a, b) => a.createdTime.compareTo(b.createdTime));
    if (chats.isEmpty) {
      createNewChat();
      return;
    }
    emit(ChatStorageLoaded(chats: chats, selected: state.selected));
  }

  void createNewChat() async {
    emit(const ChatStorageLoading(selected: 0));
    await repository.createChat(
      Chat(
        messages: [],
        createdTime: DateTime.now(),
        updatedTime: DateTime.now(),
        title: 'New Chat',
        isArchived: false,
      ),
    );
    loadChats();
  }

  void deleteChat(int id) async {
    if (state is ChatStorageLoaded) {
      final chats = (state as ChatStorageLoaded).chats;
      emit(ChatStorageLoading(selected: state.selected));
      final chatId = chats[id].id;
      if (chatId == null) {
        throw ChatStorageException();
      }
      await repository.deleteChat(chatId);
    }
    loadChats();
  }
}
