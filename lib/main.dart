import 'package:chat_gui/chat/cubit/chat_prompt_cubit.dart';
import 'package:chat_gui/chat/ui/chat_page.dart';
import 'package:chat_gui/storage/ui/chats_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LLaMA Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => ChatPromptCubit(),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            shape: const BeveledRectangleBorder(),
            child: ChatsList(),
            width: 250,
          ),
          Expanded(child: ChatPage()),
        ],
      ),
    );
  }
}
