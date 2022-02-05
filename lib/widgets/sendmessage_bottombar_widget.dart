import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/providers/chat.dart';
import 'package:no_signal/providers/user_data.dart';

import '../api/database/create_chats.dart';
import '../themes.dart';

class SendMessageWidget extends ConsumerWidget {
  const SendMessageWidget({
    Key? key,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Chatting chat = ref.watch(chatProvider);
    final user = ref.watch(currentLoggedUserProvider);

    Future<void> _sendMessage(String message) async {
      if (message.isEmpty) return;

      Chat data = Chat(
          senderName: user!.name!,
          senderid: user.id!,
          message: message,
          time: DateTime.now());

      try {
        await chat.sendMessage(data);
        _textController.clear();
      } catch (e) {
        // print(e);
      }
    }

    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: TextFormField(
                controller: _textController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableIMEPersonalizedLearning: true,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusColor: NoSignalTheme.whiteShade1,
                  fillColor: NoSignalTheme.whiteShade1,
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.insert_emoticon),
                    splashRadius: 10,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _sendMessage(_textController.text);
            },
            child: CircleAvatar(
                backgroundColor: NoSignalTheme.lightBlueShade,
                radius: 22.0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
