part of 'chat_storage_cubit.dart';

@immutable
sealed class ChatStorageState {
  final int selected;

  const ChatStorageState({required this.selected});
}

final class ChatStorageInitial extends ChatStorageState {
  const ChatStorageInitial({required super.selected});
}

class ChatStorageLoading extends ChatStorageState {
  const ChatStorageLoading({required super.selected});
}

class ChatStorageLoaded extends ChatStorageState {
  final List<Chat> chats;

  const ChatStorageLoaded({required this.chats, required super.selected});
}
