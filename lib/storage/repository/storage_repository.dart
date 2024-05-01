import 'package:chat_gui/storage/models/chat.dart';
import 'package:localstore/localstore.dart';

class ChatStorageRepository {
  final db = Localstore.instance;
  static const collectionKey = 'chats';

  // Create
  Future<void> createChat(Chat chat) async {
    // gets new id
    final id = db.collection(collectionKey).doc().id;
    chat.id = id;
    // save the item
    db.collection(collectionKey).doc(id).set(
          chat.toJson(),
        );
  }

  // Read
  Future<Iterable<Chat>> getAllChats() async {
    final documents = await db.collection(collectionKey).get();
    if (documents == null) {
      return [];
    }
    final chats = documents.values.map((chatJson) => Chat.fromJson(chatJson));
    return chats;
  }

  Future<Chat> getChatById(String id) async {
    final chatJson = await db.collection(collectionKey).doc(id).get();
    if (chatJson == null) {
      throw ChatStorageException();
    }
    return Chat.fromJson(chatJson);
  }

  // Update
  Future<void> updateChat(String id, Chat updatedChat) async {
    await db.collection(collectionKey).doc(id).set(updatedChat.toJson());
  }

  // Delete
  Future<void> deleteChat(String id) async {
    await db.collection(collectionKey).doc(id).delete();
  }

  Future<void> deleteAll() async {
    await db.collection(collectionKey).delete();
  }
}

class ChatStorageException implements Exception {}
