import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:no_signal/models/user.dart';

class ServerApi {
  final Client client;
  late final Account account;
  late final Database database;
  late final Storage storage;
  // late User user;

  ServerApi(this.client) {
    account = Account(client);
    database = Database(client);
    storage = Storage(client);
    // _getAccount();
  }

  Future<List<UserDetails>?> getUsersList() async {
    try {
      final response = await database.listDocuments(collectionId: 'chats');
      final List<UserDetails> users = [];
      final temp = response.documents;

      for (var element in temp) {
        users.add(UserDetails.fromMap(element.data));
      }
      return users;
    } on AppwriteException {
      rethrow;
    }
  }
}
