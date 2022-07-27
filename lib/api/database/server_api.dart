import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'package:no_signal/utils/split_string.dart';

/// This class contains all the functions which can't be performed on client side
/// so we are making a seperate class to perform these server side functions.
/// Since the api are different from the client side, we are using the `dart_appwrite`
class ServerApi {
  // Note: These Classes are from `dart_appwrite` package.
  // So there are more functionalities and features than the client side package
  final Client client;
  late final Account account;
  late final Databases database;

  /// Constructor to initialize the client and other api services
  ServerApi(this.client) {
    account = Account(client);
    database = Databases(client, databaseId: ApiInfo.databaseId);
  }

  /// Get the list of all the documents of users you had convo with
  ///  That document usually contains the last message and the time of the last message
  // Future<List<ServerUser>?> getConvoUsersList() async {
  //   try {
  //     final response = await database.listDocuments(collectionId: 'chats');
  //     final List<ServerUser> users = [];
  //     final temp = response.documents;

  //     for (var element in temp) {
  //       users.add(ServerUser.fromMap(element.data));
  //     }
  //     return users;
  //   } on AppwriteException {
  //     rethrow;
  //   }
  // }

  /// This function will create a new Convo Collection between two users
  /// If the collection exists or not, it will return the collection Id.
  Future<String?> createConversation(
      String curruserId, String otheruserId) async {
    /// For collection id, we are using the combination of the two user id
    /// collectionId = '${curruserId/2}_${otheruserId/2}'; or
    /// collectionId = '${otheruserId/2}_${curruserId/2}';
    /// Because curruser and otheruserId is interchangable for both the users
    /// Divide by 2 means we are creating a substring of the user id of length
    /// half of the current userId.
    /// Then We are concatenating those two substring with '_'.
    /// This is the collection id.
    /// Currently this is the way, I am making the collection.
    /// OfCourse, this can be improved a lot better.
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
            // If there is any other error, we will throw it
            rethrow;
          }
        }
      } else {
        // Same goes for here. Anything can happen between the two tries
        rethrow;
      }
    }

    /// If the collection attributes are empty, then we will define those attributes
    if (collection.attributes.isEmpty) {
      await _defineDocument(collection.$id);
    }
    // Return the collection id
    return collection.$id;
  }

  /// This function will define the attributes of the collection
  /// This function will be called only once when the collection is created
  /// A private function cause we don't want that to be called from outside
  Future<void> _defineDocument(String collectionId) async {
    // Defining attributes
    try {
      // You are free to choose your own key name.
      // But make to sure to replace those things in the model too.
      await database.createStringAttribute(
          collectionId: collectionId,
          key: "sender_name",
          size: 255,
          xrequired: true);
      await database.createStringAttribute(
          collectionId: collectionId,
          key: "sender_id",
          size: 255,
          xrequired: true);
      await database.createStringAttribute(
          collectionId: collectionId,
          key: "message",
          size: 255,
          xrequired: true);
      await database.createStringAttribute(
          collectionId: collectionId, key: "time", size: 255, xrequired: true);
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
