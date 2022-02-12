import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/pages/chat/chat_state.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/providers/user_data.dart';

import '../pages/chat/chat_services.dart';

///
/// A Provider to access the [ChatServicesNotifier]
///
final chatProvider = StateNotifierProvider.autoDispose<ChatServicesNotifier,
    ChatState>((ref) {
  return ChatServicesNotifier(
      client: ref.watch(clientProvider),
      user: ref.watch(currentLoggedUserProvider));
});


