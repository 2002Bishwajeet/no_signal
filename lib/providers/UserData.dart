import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/database/create_account.dart';

final userDataClassProvider = Provider<UserData>((ref) {
  return UserData(ref.read(clientProvider));
});
