import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';

/// [ChatServices]
/// The services neccessary to work with the [Chat] model.
/// These are all the services for client Side.
/// Since its a State Notifier it will notify if something changes
/// In Riverpod, no need to call `notifyListeners()`
/// Just use [state] to update the state and it will be updated automatically
class ChatServices extends StateNotifier<List<Chat>> {
  final Client client;
  late final Database database;
  late final Account account;
  late final Realtime realtime;
  late RealtimeSubscription subscription;

  ChatServices({required this.client}) : super([]) {
    database = Database(client);
    account = Account(client);
    realtime = Realtime(client);
    subscription = realtime.subscribe(['collections.chats.documents']);
    getOldMessages();
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
  /// It will return a list of [Chat] objects.
  Future<void> getOldMessages() async {
    try {
      final DocumentList temp =
          await database.listDocuments(collectionId: 'chats');
      // print('${temp.data['documents']} temp.data print');
      final response = temp.documents;
      // print(response);
      for (var element in response) {
        state.add(Chat.fromMap(element.data));
      }
    } on AppwriteException {
      rethrow;
    }
  }

  /// [getNewMessages]
  ///
  /// A realtime function to receive new messages from the database.
  /// Appwrite Realtime API only notifies new document changes in the collection.
  /// So we would need to listen to the collection and get the new messages.
  /// That's why we made a function to [getOldMessages]..
  void getNewMessages() {
    try {
      subscription.stream.listen((chat) {
        Chat data = Chat.fromMap(chat.payload);
        state.add(data);
      });
    } on AppwriteException {
      rethrow;
    }
  }

  /// [closeStream]
  ///
  /// Close the realtime stream
  /// Will be called when the user backs from chat Screen
  @override
  void dispose() {
    subscription.close();
    super.dispose();
  }
}
