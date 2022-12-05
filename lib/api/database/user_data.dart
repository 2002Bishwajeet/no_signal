import 'dart:developer';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:no_signal/models/user.dart';
import 'package:no_signal/utils/api.dart';

/// [UserData] class
/// This class is used to handle the user data
/// All the related methods to users are here
/// Say Add Profile Picture, Update Profile, Add User, Update User, Delete User etc
///
class UserData {
  // We will be getting the instance of client through a provider
  final Client client;

  //  Database object to connect with the database and perform CRUD operations
  late Databases database;

  // Storage object to connect with the storage to upload profile picture
  late Storage storage;

  // Account object to connect with the account to get the unique user id
  // also to update some details of the user
  late Account account;

  // Initialize the class with the client
  UserData(this.client) {
    account = Account(client);
    storage = Storage(client);
    database = Databases(client);
  }

  /// [uploadProfilePicture]
  /// This method is used to add profile picture to the user
  /// It takes the filepath of the image and the imgName as parameters
  /// After successful upload of the image it returns the unique id of the image
  /// Also we are free to choose the fileId of the image
  /// But here we don't need for that
  ///
  ///
  Future<String?> uploadProfilePicture(String filePath, String imgName, Uint8List imageBytes) async {
    try {
      final res = await account.get();

      final bytes = imageBytes.map((e) => e).toList();

      models.File? result = await storage.createFile(
        bucketId: ApiInfo.storagebucketId,
        file: InputFile(filename: imgName, path: filePath, bytes: bytes),
        fileId: 'unique()',
        permissions: [Permission.read(Role.any()), Permission.read(Role.user(res.$id))],
        // Make sure to give [role:all]
        // So that every authenticated user can access it
        // If you don't give any read permissions, by default the sole user
        // can access it.
        // We are keeping write function blank. It by defaults gives write permissions
        // to the user only and that's what we only want.
      );
      return result.$id;
    } catch (e) {
      log('$e');
      rethrow;
    }
  }

  /// [addUser]
  /// This method is used to add a new user to the database when you signup
  /// It takes all the things which you are supposed to fill in the [CreateAccountPage]
  /// It returns void as we don't want anything to be returned
  Future<void> addUser(String name, String bio, String imgId) async {
    // Get the details about the current logged in user
    final res = await account.get();

    try {
      //  We will be updating his name in the Users Api
      await account.updateName(name: name);
      // Additional data of the user will be written in the collection
      await database.createDocument(databaseId: ApiInfo.databaseId, collectionId: 'users', documentId: res.$id, data: {
        'name': name,
        'bio': bio,
        'imgId': imgId,
        'email': res.email,
        'id': res.$id,
      }, permissions: [
        Permission.read(Role.any()),
        Permission.read(Role.user(res.$id))
      ]);
    } catch (_) {
      rethrow;
    }
  }

  /// [getCurrentUser]
  /// This method is used to get the current user details
  /// It returns the [NoSignalUser] object which contains all the details of the user
  ///  We will use this object to display the user details in the [HomePage] and [SettingsPage]
  Future<NoSignalUser?> getCurrentUser() async {
    try {
      final user = await account.get();
      final data =
          await database.getDocument(databaseId: ApiInfo.databaseId, collectionId: 'users', documentId: user.$id);
      final img = await _getProfilePicture(data.data['imgId']);
      return NoSignalUser.fromMap(data.data).copyWith(image: img);
    } catch (_) {
      rethrow;
    }
  }

  /// [getUsersList]
  /// A function which returns the list of current users in the database
  /// These are those users who are currently registered in our app
  Future<List<NoSignalUser>> getUsersList() async {
    try {
      final response = await database.listDocuments(databaseId: ApiInfo.databaseId, collectionId: 'users');
      final List<NoSignalUser> users = [];
      final temp = response.documents;
      // If the list is empty, return an empty list
      if (temp.isEmpty) {
        return users;
      }
      // For loop for converting the data to our [NoSignalUser] object
      for (var element in temp) {
        final memImage = await _getProfilePicture(element.data['imgId'] as String);
        users.add(NoSignalUser.fromMap(element.data).copyWith(image: memImage));
      }
      return users;
    } on AppwriteException {
      rethrow;
    }
  }

  /// [_getProfilePicture]
  /// This method is used to get the profile picture of the user
  /// It takes the unique id of the image as a parameter
  /// It returns the image in the form of a [Uint8List]
  ///
  /// This is a private function and would hardly be used outside this class
  Future<Uint8List> _getProfilePicture(String fileId) async {
    try {
      final data = await storage.getFilePreview(bucketId: 'default', fileId: fileId);
      return data;
    } on AppwriteException {
      rethrow;
    }
  }

  /// [getProfilePicturebyuserId]
  /// This method is used to get the profile picture of the user
  /// It takes the unique id of the user as a parameter
  /// For finding the [userId] quicker we are using Queries
  @Deprecated("This method is deprecated. Use _getProfilePicture instead")
  Future<Uint8List> getProfilePicturebyuserId(String id) async {
    try {
      final response =
          await database.getDocument(databaseId: ApiInfo.databaseId, collectionId: 'users', documentId: id);
      String? pictureId;

      // So here comes using the data - the first and foremost document
      pictureId = response.data['imgId'];

      final data = await storage.getFilePreview(
        bucketId: 'default',
        fileId: pictureId as String,
      );
      return data;
    } on AppwriteException catch (e) {
      log('$e');
      rethrow;
    }
  }
}
