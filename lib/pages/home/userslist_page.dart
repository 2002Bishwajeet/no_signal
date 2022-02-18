import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/pages/chat/chat_page.dart';
import 'package:no_signal/providers/server.dart';
import 'package:no_signal/providers/user_data.dart';

class UsersListPage extends ConsumerWidget {
  static const String routeName = '/usersListPage';
  const UsersListPage({Key? key}) : super(key: key);

  ListTile usersTile(
      {required String name,
      required String bio,
      required Uint8List imageUrl,
      VoidCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: MemoryImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(bio),
      onTap: onTap ?? () {},
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ListTile> _users = [];
    final users = ref.watch(usersListProvider).asData?.value;
    final curUser = ref.watch(currentLoggedUserProvider);

    void _onTap(String userId) async {
      final id = await ref
          .watch(serverProvider)
          .createConversation(curUser!.id!, userId);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(
                collectionId: id!,
              )));
    }

    users?.sort((a, b) => a.name.compareTo(b.name));
    users?.forEach((user) async {
      if (curUser!.id != user.id) {
        _users.add(usersTile(
            name: user.name,
            bio: user.bio,
            imageUrl: user.image as Uint8List,
            onTap: () => _onTap(user.id)));
      }
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Users'),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: _users,
      ),
    );
  }
}
