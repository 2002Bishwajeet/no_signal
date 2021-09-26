import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint('http://192.168.1.26:5000/v1')
      .setProject('61372edb59641')
      .setSelfSigned(status: true);
});

