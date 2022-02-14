import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/providers/user_data.dart';

import '../api/database/chat_services.dart';

///
/// A Provider to access the [ChatServicesNotifier]
///
final chatProvider =
    StateNotifierProvider.autoDispose<ChatServicesNotifier, List<ChatBubble>>(
        (ref) {
  return ChatServicesNotifier(
      client: ref.watch(clientProvider),
      user: ref.watch(currentLoggedUserProvider));
});
