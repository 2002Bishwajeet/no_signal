import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//  Imported This package to use some server Side SDK functionality
import 'package:dart_appwrite/dart_appwrite.dart' as dart_appwrite;

final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint('http://192.168.1.26:5000/v1')
      .setProject('61372edb59641')
      .setSelfSigned(status: true);
});

final dartClientProvider = Provider<dart_appwrite.Client>((ref) {
  return dart_appwrite.Client()
      .setEndpoint('http://192.168.1.26:5000/v1')
      .setProject('61372edb59641')
      .setKey(
          'a70385532e7740a9ec00ec6bd5154978e822600f66fea1808edbf5e5413f4d2972cb703d5ec68290caf5d52532affb76dfe3310d9bd2d7e7a75f6a37715b30bbdeceb63a46d5224943c3eef33d33fbcbb5638ce364be3c3ddbc7d9ad5bdf0a928e3ad95bbc3fb079f2c901d6a43b5a90c12fe53c211698271436349ac9a46aff');
});
