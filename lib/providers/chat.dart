import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/database/create_chats.dart';

final chatProvider = Provider<Chatting>((ref) {
  return Chatting(
      dartClient: ref.watch(dartClientProvider),
      client: ref.watch(clientProvider));
});

final chatsProvider = StreamProvider.autoDispose<RealtimeMessage?>((ref) {
  return ref.watch(chatProvider).receiveMessage();
});

final oldChatsProvider = FutureProvider<List<Chat>?>((ref) async {
  return ref.watch(chatProvider).getOldMessages();
});
