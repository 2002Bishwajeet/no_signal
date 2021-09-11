import 'package:appwrite/appwrite.dart';

class Chatting {
  final Client client;
  late Database database;
  Chatting(this.client) {
    database = Database(client);
  }

  Future<void> sendMessage(String message) async {
    try {
      
    } catch (e) {
      print(e);
    }
  }
}
