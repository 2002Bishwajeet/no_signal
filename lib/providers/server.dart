import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/api/database/server_api.dart';
import 'package:no_signal/providers/client.dart';

/// Provider for accessing [ServerApi] functions
final serverProvider = Provider<ServerApi>((ref) {
  return ServerApi(ref.watch(dartclientProvider));
});
