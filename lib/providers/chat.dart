import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/providers/client.dart';

import '../api/database/create_chats.dart';


final chatProvider = Provider<ChatServices>((ref) {
  return ChatServices(client: ref.watch(clientProvider));
});

final chatsProvider = FutureProvider<RealtimeSubscription?>((ref) {
  return ref.watch(chatProvider).receiveMessage();
});

final oldChatsProvider = FutureProvider<List<Chat>?>((ref) async {
  return ref.watch(chatProvider).getOldMessages();
});
