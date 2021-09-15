import 'package:appwrite/appwrite.dart';
import 'package:no_signal/models/chat.dart';

class Chatting {
  final Client client;
  late final Database database;
  late final Account account;
  late final Realtime realtime;
  late final subscription;

  Chatting(this.client) {
    database = Database(client);
    account = Account(client);
    realtime = Realtime(client);
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
}
