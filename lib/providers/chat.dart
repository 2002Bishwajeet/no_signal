import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/providers/client.dart';

import '../api/database/chat_services.dart';

///
/// A Provider to access the [ChatServices]
///
final chatProvider =
    StateNotifierProvider.autoDispose<ChatServices, List<Chat>>((ref) {
  return ChatServices(client: ref.watch(clientProvider));
});
