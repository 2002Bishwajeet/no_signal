import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/providers/UserData.dart';

class UsersListPage extends ConsumerWidget {
  static const String routeName = '/usersListPage';
  UsersListPage({Key? key}) : super(key: key);

  ListTile usersTile(
      {required String name,
      required String bio,
      required Uint8List imageUrl}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: MemoryImage(imageUrl),
      ),
      title: Text(name),
      subtitle: Text(bio),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    List<ListTile> _users = [];
    final users = watch(usersListProvider).data?.value;
    final curUser = watch(userLoggedProvider).state;

    users?.forEach((user) async {
      if (curUser!.id != user.id) {
        _users.add(usersTile(
            name: user.name, bio: user.bio, imageUrl: user.image as Uint8List));
      }
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Users'),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: _users,
      ),
    );
  }
}
