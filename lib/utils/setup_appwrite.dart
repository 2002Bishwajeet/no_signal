// ignore_for_file: avoid_print

import 'package:dart_appwrite/dart_appwrite.dart';

//// Function to setup User Collection
/// Just run this function setting your endpoint, ProjectID and APIKey
void main() async {
  Client client = Client()
      .setEndpoint('http://appwrite.io/v1') // Replace with the endpoint 
      .setProject('[YOUR_PROJECT_ID]') // Replace with your Project ID
      .setKey('[YOUR_SECRET_API_KEY]') // Replace with your API Key
      .setSelfSigned(status: true);
  Database db = Database(client);
  await db.createCollection(
    collectionId: 'users',
    name: 'Users',
    permission: 'document',
    read: ["role:all"],
    write: [],
  );
  await db.createStringAttribute(
      collectionId: 'users', key: 'name', size: 256, xrequired: true);
  await db.createStringAttribute(
      collectionId: 'users', key: 'bio', size: 256, xrequired: false);
  await db.createStringAttribute(
      collectionId: 'users', key: 'imgId', size: 256, xrequired: false);
  await db.createEmailAttribute(
      collectionId: 'users', key: 'email', xrequired: true);
  await db.createStringAttribute(
      collectionId: 'users', key: 'id', size: 256, xrequired: true);

  print("Collection created");
}
