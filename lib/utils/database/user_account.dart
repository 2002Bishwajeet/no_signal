import 'dart:typed_data';

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

  Future<List<UserPerson>?> getUsersList() async {
    try {
      final response =
          await database.listDocuments(collectionId: '613c3298e2a69');
      final List<UserDetails> users = [];
      final temp = response.data['documents'] as List<dynamic>;
      final List<UserPerson> _users = [];

      temp.forEach((element) {
        users.add(UserDetails.fromMap(element));
      });
      users.forEach((element) async {
        final imgurl = await getProfilePicture(element.url as String);
        _users.add(UserPerson(
            name: element.name,
            bio: element.bio,
            id: element.id,
            email: element.email,
            image: imgurl));
      });
      return _users;
    } on AppwriteException catch (e) {
      throw e;
    }
  }

  Future<Uint8List> getProfilePicture(String fileId) async {
    try {
      final data = await storage.getFilePreview(fileId: fileId);
      return data.data;
    } on AppwriteException catch (e) {
      throw e;
    }
  }
}
