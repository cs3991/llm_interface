import 'package:chat_gui/chat/cubit/chat_prompt_cubit.dart';
import 'package:chat_gui/chat/ui/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    _textController.addListener(_changed);
  }

  @override
  void dispose() {
    _textController.removeListener(_changed);
    myFocusNode.dispose();
    super.dispose();
  }

  _changed() {
    context.read<ChatPromptCubit>().updatePrompt(_textController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: BlocConsumer<ChatPromptCubit, ChatPromptState>(
          listener: (context, state) {
            if (_textController.text != state.prompt) {
              _textController.text = state.prompt;
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: List.generate(
                      state.discussion.length,
                      (i) => MessageView(state.discussion[i]),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: myFocusNode,
                        autofocus: true,
                        controller: _textController,
                        onSubmitted: (value) {
                          context.read<ChatPromptCubit>().sendPrompt();
                          myFocusNode.requestFocus();
                        },
                        // onChanged: (value) =>
                        //     context.read<ChatPromptCubit>().updatePrompt(value),
                        decoration: const InputDecoration(
                          hintText: 'Ask something!',
                          // label: Text('Ask something!'),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<ChatPromptCubit>().sendPrompt();
                        myFocusNode.requestFocus();
                      },
                      icon: const Icon(Icons.send_rounded),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
