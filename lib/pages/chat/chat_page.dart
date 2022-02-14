import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    NoSignalUser? user = ref.watch(currentLoggedUserProvider);
    final chatList = ref.watch(chatProvider);

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
            backgroundImage: CachedNetworkImageProvider(
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
          children: [
            ...chatList,
          ],
        ),
        bottomNavigationBar: SendMessageWidget(
            textController: _textController,
            onSend: () async => _sendMessage(_textController.text)),
      ),
    );
  }
}
