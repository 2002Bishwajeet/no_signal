import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            ),
            ListTile(
              title: Text('Account'),
              leading: Icon(Icons.account_circle),
            ),
            ListTile(
              title: Text('Linked devices'),
              leading: Icon(Icons.link),
            ),
            Divider(
              height: 19,
            ),
            ListTile(
              title: Text('Appearance'),
              leading: Icon(Icons.color_lens),
            ),
            ListTile(
              title: Text('Chats'),
              leading: Icon(Icons.chat),
            ),
            ListTile(
              title: Text('Notifications'),
              leading: Icon(Icons.notifications),
            ),
            ListTile(
              title: Text('Privacy'),
              leading: Icon(Icons.lock),
            ),
            ListTile(
              title: Text('Data and storage'),
              leading: Icon(Icons.storage),
            ),
            Divider(),
            ListTile(
              title: Text('Help and feedback'),
              leading: Icon(Icons.help),
            ),
            ListTile(
              title: Text('Invite your friends'),
              leading: Icon(Icons.mail),
            ),
            ListTile(
              title: Text('Link to repo'),
              trailing: Icon(Icons.link),
              leading: FaIcon(FontAwesomeIcons.github),
            ),
          ],
        ),
      ),
    );
  }
}
