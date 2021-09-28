import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as appwrite;

final clientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint('http://192.168.1.26:5000/v1')
      .setProject('61372edb59641')
      .setSelfSigned(status: true);
});

final dartclientProvider = Provider<appwrite.Client>((ref) {
  return appwrite.Client()
      .setEndpoint('http://192.168.1.26:5000/v1')
      .setProject('61372edb59641')
      .setKey(
          '985baaa640bdabeb06c3f11f966fcc5ceab4f16740f5d48ff62e694060119f2213f3489d53cd2108c4a3af27c96d12114dfc137bbfabc3cc35a54550b516f1c359620fadfd4c4511842c89713fcabe234d880741185ef00e8583cfd33f75b90f47bccda97ee9391c5fb80d08bdc339c35dead255db522309bba4979b762a1332')
      .setSelfSigned(status: true);
});
