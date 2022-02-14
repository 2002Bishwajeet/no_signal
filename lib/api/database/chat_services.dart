import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/models/user.dart';

import '../../themes.dart';

/// [ChatServicesNotifier]
/// The services neccessary to work with the [Chat] model.
/// These are all the services for client Side.
/// Since its a State Notifier it will notify if something changes
/// In Riverpod, no need to call `notifyListeners()`
/// Just use [state] to update the state and it will be updated automatically
class ChatServicesNotifier extends StateNotifier<List<ChatBubble>> {
  final Client client;
  late final Database database;
  late final Account account;
  late final Realtime realtime;
  late RealtimeSubscription subscription;

  /// The List of [Chat]s fetched for the particular collection
  final List<Chat> _chats = [];

  /// Current LoggedIn [User] to be obtained from Constructor
  NoSignalUser? user;

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

  /// Function to add [Chat] then parse it to [ChatBubble]
  void addChats(Chat chat) {
    _chats.add(chat);
    state.add(_parseChat(chat));
  }

  ChatServicesNotifier({required this.client, this.user}) : super([]) {
    database = Database(client);
    account = Account(client);
    realtime = Realtime(client);
    subscription = realtime.subscribe(['collections.chats.documents']);
    getOldMessages(user);

    getNewMessages();
  }

  /// Send a new message to the user.
  /// Will update the function to add support for other multimedia
  ///
  Future<void> sendMessage(Chat chat) async {
    try {
      await database.createDocument(
        collectionId: 'chats',
        documentId: 'unique()',
        read: ['role:all'],
        write: ['role:all'],
        data: chat.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Function to receive the old messages from the database.
  /// This will be a one time call for this function.
  ///
  /// It will update the [ChatState]
  Future<void> getOldMessages(NoSignalUser? user) async {
    try {
      final DocumentList temp =
          await database.listDocuments(collectionId: 'chats');
      // print('${temp.data['documents']} temp.data print');
      final response = temp.documents;
      // print(response);
      for (var element in response) {
        _chats.add(Chat.fromMap(element.data));
      }
      // state(_chats.map((e) => _parseChat(e)));
      state = _chats.map((e) => _parseChat(e)).toList();
    } on AppwriteException catch (_) {
      rethrow;
    }
  }

  /// [getNewMessages]
  ///
  /// A realtime function to receive new messages from the database.
  /// Appwrite Realtime API only notifies new document changes in the collection.
  /// So we would need to listen to the collection and get the new messages.
  /// That's why we made a function to [getOldMessages].
  void getNewMessages() {
    subscription.stream.listen((chat) {
      Chat data = Chat.fromMap(chat.payload);
      _chats.add(data);
      state = [...state, _parseChat(data)];
    });
  }

  /// [closeStream]
  ///
  /// Close the realtime stream
  /// Will be called when the user backs from chat Screen
  @override
  void dispose() {
    subscription.close();
    log('Stream Closed');
    super.dispose();
  }
}
