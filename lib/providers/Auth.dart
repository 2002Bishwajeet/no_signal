import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/auth/Authentication.dart';

final authProvider = Provider<Authentication>((ref) {
  return Authentication(ref.watch(clientProvider));
});

final userProvider = FutureProvider<User?>((ref) async {
  return Authentication(ref.watch(clientProvider)).getAccount();
});

final userLoggedProvider = StateProvider<User?>((ref) {
  return null;
});

final userLoggedInProvider = StateProvider<bool?>((ref) {
  return null;
});
