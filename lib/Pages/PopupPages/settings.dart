import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/Auth.dart';

class SettingsScreen extends ConsumerWidget {
  static const routename = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userData = watch(userLoggedProvider).state;
    final Uint8List? argument =
        ModalRoute.of(context)?.settings.arguments as Uint8List;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: argument != null
                        ? MemoryImage(argument) as ImageProvider
                        : AssetImage('assets/images/avatar.png'),
                  ),
                  Expanded(
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: 2),
                      title: Text(userData?.name ?? 'No name',
                          style: Theme.of(context).textTheme.headline5),
                      subtitle: Text(
                        userData?.email ?? 'No email',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
