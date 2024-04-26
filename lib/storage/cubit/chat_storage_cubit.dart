import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_storage_state.dart';

class ChatStorageCubit extends Cubit<ChatStorageState> {
  ChatStorageCubit() : super(ChatStorageInitial());
}
