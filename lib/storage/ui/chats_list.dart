import 'package:chat_gui/storage/cubit/chat_storage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsList extends StatefulWidget {
  // final chats = [
  //   'Test',
  //   'Selected',
  //   'other chats',
  // ];
  // final selected = 1;

  const ChatsList({super.key});

  @override
  State<ChatsList> createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatStorageCubit, ChatStorageState>(
      builder: (context, chatStorageState) {
        if (chatStorageState is ChatStorageLoaded) {
          final chats = chatStorageState.chats;
          return BlocBuilder<ChatStorageCubit, ChatStorageState>(
            builder: (context, state) {
              return ListView.builder(
                itemCount: chats.length + 1,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(2),
                  child: index == chats.length
                      ? IconButton(
                          onPressed: () {
                            context.read<ChatStorageCubit>().createNewChat();
                          },
                          icon: const Icon(Icons.add_rounded),
                        )
                      : ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          dense: true,
                          selected: index == state.selected,
                          enabled: true,
                          onTap: () {
                            context.read<ChatStorageCubit>().changeChat(index);
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_rounded),
                            onPressed: () {
                              context
                                  .read<ChatStorageCubit>()
                                  .deleteChat(index);
                            },
                          ),
                          title: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            chats[index].title,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.fontSize),
                          ),
                        ),
                ),
              );
            },
          );
        }
        if (chatStorageState is ChatStorageInitial) {
          context.read<ChatStorageCubit>().loadChats();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
