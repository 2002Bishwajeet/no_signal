import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/client.dart';
import 'package:no_signal/utils/database/create_chats.dart';

final chatProvider = Provider<Chatting>((ref) {
  return Chatting(ref.read(clientProvider));
});
