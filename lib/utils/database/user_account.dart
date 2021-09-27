import 'package:appwrite/appwrite.dart';
import 'package:no_signal/models/user.dart';


class UserData {
  final Client client;
  late Database database;
  late Storage storage;
  late Account account;
  UserData(this.client) {
    account = Account(client);
    storage = Storage(client);
    database = Database(client);
  }

  Future<String?> addProfilePicture(String filePath, String imgName) async {
    try {
      var result = await storage.createFile(
          file: await MultipartFile.fromPath('file', filePath,
              filename: imgName));
      return result.data['\$id'];
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser(String name, String bio, String url) async {
    Response<dynamic> res = await account.get();
    User user = User.fromMap(res.data);
    try {
      await database.createDocument(collectionId: '613c3298e2a69', data: {
        'name': name,
        'bio': bio,
        'url': url,
        'email': user.email,
        'id': user.id
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getUsersList() async {

  }
}
