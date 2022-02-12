import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/models/user.dart';

import '../../themes.dart';

@immutable
class ChatState {
  /// The List of [Chat]s fetched for the particular collection
  final List<Chat> _chats;

  /// Current LoggedIn [User] to be obtained from Constructor
  final NoSignalUser? user;

  /// [ChatBubbles] which will be parsed from [Chat] data
  final List<ChatBubble> _chatBubbles = <ChatBubble>[];

  /// getter for _chatBubbles
  List<ChatBubble> get chatBubbles => _chatBubbles;

  /// getter for _chats
  List<Chat> get chats => _chats;

  /// Private Function for parsing [Chat] data to [ChatBubble]
  ChatBubble _parseChat(Chat chat) {
    return ChatBubble(
      margin: const EdgeInsets.only(top: 10),
      child: Text(chat.message),
      alignment:
          user!.id == chat.senderid ? Alignment.topRight : Alignment.topLeft,
      shadowColor: Colors.transparent,
      backGroundColor: user!.id != chat.senderid
          ? Colors.grey
          : NoSignalTheme.lightBlueShade,
      clipper: ChatBubbleClipper1(
          type: user!.id == chat.senderid
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble),
    );
  }

  /// Function to parse [Chat] data to [ChatBubble]
  void addChats(Chat chat) {
    _chats.add(chat);
    _chatBubbles.add(_parseChat(chat));
  }

  /// [ChatState] Constructor
  ChatState(this._chats, {this.user}) {
    for (var chat in _chats) {
      _chatBubbles.add(_parseChat(chat));
    }
  }
}
