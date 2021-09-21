import 'package:appwrite/appwrite.dart';
import 'package:no_signal/models/chat.dart';

import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;

class Chatting {
  final Client client;
  final appwrite.Client dartClient;
  late final Database database;
  late final Account account;
  late final Realtime realtime;

  late final appwrite.Database _database;
  late final appwrite.Account _account;

  Chatting({required this.client, required this.dartClient}) {
    database = Database(client);
    account = Account(client);
    realtime = Realtime(client);

    _database = appwrite.Database(dartClient);
    _account = appwrite.Account(dartClient);
  }

  Future<void> sendMessage(Chat chat) async {
    try {
      await database.createDocument(
        collectionId: '613f6523da871',
        data: chat.toMap(),
      );
    } on AppwriteException catch (e) {
      print(e);
    }
  }

  Future<List<Chat>?> getOldMessages() async {
    try {
      final temp = await _database.listDocuments(collectionId: '613f6523da871');
      // print('${temp.data['documents']} temp.data print');
      final List<Chat> _chats = [];
      final response = temp.data['documents'] as List<dynamic>;
      // print(response);
      response.forEach((element) {
        _chats.add(Chat.fromMap(element));
      });
      return _chats;
    } on AppwriteException catch (e) {
      throw e;
    }
  }

  Stream<RealtimeMessage?> receiveMessage() {
    try {
      RealtimeSubscription data =
          realtime.subscribe(['collections.613f6523da871.documents']);

      return data.stream;
    } on AppwriteException catch (e) {
      print(e);
      throw e;
    }
  }
}
