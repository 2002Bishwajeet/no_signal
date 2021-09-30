import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/database/user_account.dart';

final userDataClassProvider = Provider<UserData>((ref) {
  return UserData(ref.watch(clientProvider));
});

final usersListProvider = FutureProvider<List<UserPerson>?>((ref) {
  return ref.watch(userDataClassProvider).getUsersList();
});

final imageUrlProvider =
    FutureProvider.family<Uint8List, String>((ref, id) async {
  return ref.watch(userDataClassProvider).getProfilePicturebyuserId(id);
});
