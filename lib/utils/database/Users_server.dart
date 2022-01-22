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

  // Future<void> _getAccount() async {
  //   try {
  //     final response = await account.get();
  //     user = User.fromMap(response.data);
  //   } on AppwriteException catch (e) {
  //     throw e;
  //   }
  // }

  Future<List<UserDetails>?> getUsersList() async {
    try {
      final response =
          await database.listDocuments(collectionId: '613c3298e2a69');
      final List<UserDetails> users = [];
      final temp = response.data['documents'] as List<dynamic>;

      for (var element in temp) {
        users.add(UserDetails.fromMap(element));
      }
      return users;
    } on AppwriteException {
      rethrow;
    }
  }
}
