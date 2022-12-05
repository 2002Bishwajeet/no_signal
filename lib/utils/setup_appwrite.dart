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

  Databases db = Databases(client);

  db.create(name: 'No Signal', databaseId: 'nosignal');

  Storage storage = Storage(client);
  await db.createCollection(
      databaseId: 'nosignal', collectionId: 'users', name: 'Users', permissions: [Permission.read(Role.any())]);
  await db.createStringAttribute(
      databaseId: 'nosignal', collectionId: 'users', key: 'name', size: 256, xrequired: true);
  await db.createStringAttribute(
      databaseId: 'nosignal', collectionId: 'users', key: 'bio', size: 256, xrequired: false);
  await db.createStringAttribute(
      databaseId: 'nosignal', collectionId: 'users', key: 'imgId', size: 256, xrequired: false);
  await db.createEmailAttribute(databaseId: 'nosignal', collectionId: 'users', key: 'email', xrequired: true);
  await db.createStringAttribute(databaseId: 'nosignal', collectionId: 'users', key: 'id', size: 256, xrequired: true);
  print("Collection created");

  // Creating a new Bucket to store Profile Photos
  await storage.createBucket(
      bucketId: 'profile-photos',
      name: 'Profile Photos',
      permissions: [Permission.read(Role.any()), Permission.write(Role.users())]);
  print('Bucket Created');
}
