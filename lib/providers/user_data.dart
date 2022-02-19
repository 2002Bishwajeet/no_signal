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
final usersListProvider = FutureProvider<List<NoSignalUser>>((ref) {
  return ref.watch(userDataClassProvider).getUsersList();
});

/// State Provider for the Current LoggedIn user. This would be used to access
/// any of its data from anywhere in the app. That's the power of StateProvider.
final currentLoggedUserProvider = StateProvider<NoSignalUser?>((ref) {
  return null;
});
