import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/utils/utils.dart';

/// This class contains all the functions which can't be performed on client side
/// so we are making a seperate class to perform these server side functions.
/// Since the api are different from the client side, we are using the `dart_appwrite`
class ServerApi {
  final Client client;
  late final Account account;
  late final Database database;
  late final Storage storage;

  /// Constructor to initialize the client and the other api services
  ServerApi(this.client) {
    account = Account(client);
    database = Database(client);
    storage = Storage(client);
  }

  /// Get the list of all the documents of users you had convo with
  ///  That document usually contains the last message and the time of the last message
  Future<List<ServerUser>?> getConvoUsersList() async {
    try {
      final response = await database.listDocuments(collectionId: 'chats');
      final List<ServerUser> users = [];
      final temp = response.documents;

      for (var element in temp) {
        users.add(ServerUser.fromMap(element.data));
      }
      return users;
    } on AppwriteException {
      rethrow;
    }
  }

  /// This function will create a new Convo Collection between two users
  /// If the collection exists or not, it will return the collection Id.
  Future<String?> createConversation(
      String curruserId, String otheruserId) async {
    // For collection id, we are using the combination of the two user id
    // collectionId = '${curruserId}_$otheruserId'; or
    // collectionId = '${otheruserId}_$curruserId';
    // Because curruser and otheruserId is interchangable for both the users
    // Currently this is the way, I am making the collection.
    // OfCourse, this can be improved a lot better
    Collection? collection;
    // Check if the collection exists or not
    try {
      // We will try to get the collection in the first try
      collection = await database.getCollection(
          collectionId:
              '${curruserId.splitByLength((curruserId.length) ~/ 2)[0]}_${otheruserId.splitByLength((otheruserId.length) ~/ 2)[0]}');
    } on AppwriteException catch (e) {
      // If the collection doesn't exist, we will try with another id
      if (e.code == 404) {
        try {
          collection = await database.getCollection(
              collectionId:
                  '${otheruserId.splitByLength((otheruserId.length) ~/ 2)[0]}_${curruserId.splitByLength((curruserId.length) ~/ 2)[0]}');
        } on AppwriteException catch (e) {
          // If it still doesn't exists then we will create a new collection
          if (e.code == 404) {
            // Create a new collection
            collection = await database.createCollection(
              collectionId:
                  '${curruserId.splitByLength((curruserId.length) ~/ 2)[0]}_${otheruserId.splitByLength((otheruserId.length) ~/ 2)[0]}',
              name:
                  '${curruserId.splitByLength((curruserId.length) ~/ 2)[0]}_${otheruserId.splitByLength((otheruserId.length) ~/ 2)[0]}',
              read: ["user:$curruserId", "user:$otheruserId"],
              write: ["user:$curruserId", "user:$otheruserId"],
              permission: 'collection',
            );
          } else {
            // If there es any other error, we will throw it
            rethrow;
          }
        }
      } else {
        // Same goes for here. Anything can happen between the two tries
        rethrow;
      }
    }
    if (collection.attributes.isEmpty) {
      await _defineDocument(collection.$id);
    }
    return collection.$id;
  }

  Future<void> _defineDocument(String collectionId) async {
    // Defining attributes
    try {
      await database.createStringAttribute(
          collectionId: collectionId,
          key: "sender_name",
          size: 255,
          xrequired: false);
      await database.createStringAttribute(
          collectionId: collectionId,
          key: "sender_id",
          size: 255,
          xrequired: false);
      await database.createStringAttribute(
          collectionId: collectionId,
          key: "message",
          size: 255,
          xrequired: false);
      await database.createStringAttribute(
          collectionId: collectionId, key: "time", size: 255, xrequired: false);
      await database.createEnumAttribute(
          collectionId: collectionId,
          key: "message_type",
          elements: ["IMAGE", "VIDEO", "TEXT"],
          xdefault: "TEXT",
          xrequired: false);
    } on AppwriteException {
      rethrow;
    }
  }
}
