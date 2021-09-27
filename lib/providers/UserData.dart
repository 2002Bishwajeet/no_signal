import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/database/Users_server.dart';
import 'package:no_signal/utils/database/user_account.dart';

final userDataClassProvider = Provider<UserData>((ref) {
  return UserData(ref.read(clientProvider));
});

final usersListProvider = FutureProvider<List<UserDetails>?>((ref) async {
  return await ref.read(dartServerProvider).getUsersList();
});

final dartServerProvider = Provider<ServerApi>((ref) {
  return ServerApi(ref.read(dartclientProvider));
});
