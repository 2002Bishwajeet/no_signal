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
  final String collectionId;
  late final Databases database;
  late final Account account;
  late final Realtime realtime;
  late RealtimeSubscription subscription;

  /// The List of [Chat]s fetched for the particular collection
  final List<Chat> _chats = [];

  /// Current LoggedIn [User] to be obtained from Constructor
  final NoSignalUser? user;

  /// getter for _chats
  List<Chat> get chats => _chats;

  /// Private Function for parsing [Chat] data to [ChatBubble]
  ChatBubble _parseChat(Chat chat) {
    return ChatBubble(
      margin: const EdgeInsets.only(top: 10),
      alignment:
          user!.id == chat.senderid ? Alignment.topRight : Alignment.topLeft,
      shadowColor: Colors.transparent,
      backGroundColor: user!.id != chat.senderid
          ? Colors.grey
          : NoSignalTheme.lightBlueShade,
      clipper: ChatBubbleClipper1(
        type: user!.id == chat.senderid
            ? BubbleType.sendBubble
            : BubbleType.receiverBubble,
      ),
      child: Text(chat.message),
    );
  }

  /// Constructor
  ChatServicesNotifier(
      {required this.client, this.user, required this.collectionId})
      : super([]) {
    database = Databases(client, databaseId: ApiInfo.databaseID);
    account = Account(client);
    realtime = Realtime(client);
    subscription = realtime.subscribe(['collections.$collectionId.documents']);
    _getOldMessages(user);
    _getRealtimeMessages();
  }

  /// Send a new message to the user.
  /// Will update the function to add support for other multimedia
  ///
  Future<void> sendMessage(Chat chat) async {
    try {
      await database.createDocument(
        collectionId: collectionId,
        documentId: 'unique()',
        data: chat.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Function to receive the old messages from the database.
  /// This will be a one time call for this function.
  ///
  /// It will update the of [state] - List<ChatBubbles>
  /// Since its not required outside of this class,
  /// it is private
  void _getOldMessages(NoSignalUser? user) async {
    try {
      final DocumentList temp =
          await database.listDocuments(collectionId: collectionId);
      final response = temp.documents;

      /// Adding the List of [Chat]s to the [_chats]
      for (var element in response) {
        _chats.add(Chat.fromMap(element.data));
      }

      /// Updating the [state]
      /// NOTE: Don't update state by calling List methods like `add()`
      /// This does not actually modify the state.
      /// Update the state as below when you want to completely modify the list
      /// or use [...state, newState] to add a new element to the existing list
      /// Using any of the List methods will not trigger rebuilds
      state = _chats.map((e) => _parseChat(e)).toList();
    } on AppwriteException catch (_) {
      rethrow;
    }
  }

  /// [_getRealtimeMessages]
  ///
  /// A realtime function to receive new messages from the database.
  /// Appwrite Realtime API only notifies new document changes in the collection.
  /// So we would need to listen to the collection and get the new messages.
  /// That's why we made a function to [getOldMessages].
  void _getRealtimeMessages() {
    subscription.stream.listen((chat) {
      Chat data = Chat.fromMap(chat.payload);
      _chats.add(data);

      /// Note: We used spread operator to keep the existing state as well as
      /// add the new element to the list.
      /// This will trigger a rebuild of the widget.
      state = [...state, _parseChat(data)];
    });
  }

  /// [closeStream]
  ///
  /// Close the realtime stream
  /// Will be called when the user backs from chat Screen
  /// Closing the stream to avoid memory leaks and unnecessary calls
  @override
  void dispose() {
    subscription.close();
    log('Stream Closed');
    super.dispose();
  }
}
