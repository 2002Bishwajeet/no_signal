import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/chat.dart';
import 'package:no_signal/providers/user_data.dart';
import 'package:no_signal/themes.dart';
import 'package:no_signal/widgets/send_message.dart';

import '../../models/chat.dart';

class ChatPage extends ConsumerWidget {
  static const String routeName = '/chat';
  ChatPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ChatPageState();
// }

// class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _textController = TextEditingController();

  final List<ChatBubble> _chatBubbles = [];

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _textController.dispose();
  //   ref.read(chatProvider.notifier).dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NoSignalUser? user = ref.watch(currentLoggedUserProvider);
    final chatList = ref.watch(chatProvider);
    for (var chat in chatList) {
      // print(user!.id == chat.senderid);
      _chatBubbles.add(ChatBubble(
        margin: const EdgeInsets.only(top: 10),
        child: Text(chat.message),
        alignment:
            user!.id == chat.senderid ? Alignment.topRight : Alignment.topLeft,
        shadowColor: Colors.transparent,
        backGroundColor: user.id != chat.senderid
            ? Colors.grey
            : NoSignalTheme.lightBlueShade,
        clipper: ChatBubbleClipper1(
            type: user.id == chat.senderid
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble),
      ));
    }

    // realtimeChats?.stream.listen((chat) {
    //   Chat data = Chat.fromMap(chat.payload);
    //   _chatBubbles.add(ChatBubble(
    //     margin: const EdgeInsets.only(top: 10),
    //     child: Text(data.message),
    //     alignment:
    //         user!.id == data.senderid ? Alignment.topRight : Alignment.topLeft,
    //     shadowColor: Colors.transparent,
    //     backGroundColor: user.id != data.senderid
    //         ? Colors.grey
    //         : NoSignalTheme.lightBlueShade,
    //     clipper: ChatBubbleClipper1(
    //         type: user.id == data.senderid
    //             ? BubbleType.sendBubble
    //             : BubbleType.receiverBubble),
    //   ));
    // });

    Future<void> _sendMessage(String message) async {
      if (message.isEmpty) return;

      Chat data = Chat(
          senderName: user!.name!,
          senderid: user.id!,
          message: message,
          time: DateTime.now());

      try {
        await ref.watch(chatProvider.notifier).sendMessage(data);
        _textController.clear();
      } catch (e) {
        rethrow;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            // realtimeChats?.close();
          },
        ),
        backgroundColor: NoSignalTheme.navyblueshade4,
        leadingWidth: 20,
        elevation: 0,
        title: const ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              'https://images.pexels.com/photos/9226510/pexels-photo-9226510.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
            ),
          ),
          title: Text('Aishwarya'),
          subtitle: Text('Online'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Scaffold(
        body: ListView(
          children: _chatBubbles,
        ),
        bottomNavigationBar: SendMessageWidget(
            textController: _textController,
            onSend: () async => _sendMessage(_textController.text)),
      ),
    );
  }
}
