import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/Authentication.dart';

final authProvider = Provider<Authentication>((ref) {
  return Authentication();
});

final userProvider = FutureProvider<void>((ref) async {
  return Authentication().checkIsLoggedIn() ;
});