import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/chat.dart';
import 'package:no_signal/providers/user_data.dart';
import 'package:no_signal/themes.dart';
import 'package:no_signal/widgets/send_message.dart';

import '../../models/chat.dart';

/// [ChatPage]
///
/// This is the chat page.
class ChatPage extends ConsumerWidget {
  /// CollectionId for the current convo
  final String collectionId;

  /// Data of the user whom the current user is chaating with
  /// The data is required to display the name and photo of the user
  final NoSignalUser chatUser;
  ChatPage({required this.collectionId, required this.chatUser, Key? key})
      : super(key: key);

  /// TextFieldController for the message input
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Get Data for the currentLoggedInUser
    NoSignalUser? user = ref.watch(currentLoggedUserProvider);

    /// Get the list of ChatData
    final chatList = ref.watch(chatProvider(collectionId));

    Future<void> _sendMessage(String message) async {
      if (message.isEmpty) return;

      /// Parse the data into a proper model
      Chat data = Chat(
          senderName: user!.name,
          senderid: user.id,
          message: message,
          time: DateTime.now());

      try {
        /// Send the message
        await ref.watch(chatProvider(collectionId).notifier).sendMessage(data);

        /// Clear the text field after sending
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
          },
        ),
        backgroundColor: NoSignalTheme.navyblueshade4,
        leadingWidth: 20,
        elevation: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: MemoryImage(
              chatUser.image!,
            ),
          ),
          title: Text(chatUser.name),
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
            onSend: () async => await _sendMessage(_textController.text)),
      ),
    );
  }
}
