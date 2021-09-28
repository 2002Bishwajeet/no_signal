import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/database/user_account.dart';

final userDataClassProvider = Provider<UserData>((ref) {
  return UserData(ref.read(clientProvider));
});

final usersListProvider = FutureProvider<List<UserPerson>?>((ref) {
  return ref.read(userDataClassProvider).getUsersList();
});
