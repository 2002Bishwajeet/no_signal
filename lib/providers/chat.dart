import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/providers/user_data.dart';

import '../api/database/chat_services.dart';

/// A Provider to access the [ChatServicesNotifier]
///
/// A StateNotifierProvider is a Provider that is used to access a StateNotifier
/// NOTE: autoDispose and family method are also used here.
/// autoDispose: When the widget is removed from the tree, the provider will be disposed.
/// It will happen when you close the chat screen with a particular user. If autodispose
/// didn't called then redudant data will be fetched.
///
/// family: This is used to group the providers.
/// This will be used to take a live paramter when this provider is called
/// currently we are using it to get the collection id (chat id) so to fetch
/// the old chats and establish a connection between it.
final chatProvider = StateNotifierProvider.autoDispose
    .family<ChatServicesNotifier, List<ChatBubble>, String>(
        (ref, collectionId) {
  return ChatServicesNotifier(
      client: ref.watch(clientProvider),
      collectionId: collectionId,
      user: ref.watch(currentLoggedUserProvider));
});
