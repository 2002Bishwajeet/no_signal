import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/client.dart';

import '../api/database/user_data.dart';

/// Provider for the [UserData] class.
/// This provider is used to access all the [UserData] methods.
///
///
final userDataClassProvider = Provider<UserData>((ref) {
  return UserData(ref.watch(clientProvider));
});

/// Provider for the [UserData] class.
/// This provider is used to get the List of  all the [User] from the database.
/// Since this invloves a Future, a FutureProvider is used.
final usersListProvider = FutureProvider<List<LocalUser>?>((ref) {
  return ref.watch(userDataClassProvider).getUsersList();
});

/// FutureProvider for a particular function in the [UserData] class.
/// This provider is used to get a profilePicture of a user by their [userId].
///
///
final imageUrlProvider =
    FutureProvider.family<Uint8List, String>((ref, id) async {
  return ref.watch(userDataClassProvider).getProfilePicturebyuserId(id);
});

final currentLoggedUserProvider = StateProvider<NoSignalUser?>((ref) {
  return null;
});
