import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:no_signal/Pages/usersListPage.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/themes.dart';
import 'package:no_signal/widgets/ChatListWidget.dart';

enum PopupItem {
  group,
  settings,
  logout,
}

class HomePage extends ConsumerWidget {
  static const routename = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    final auth = ref(authProvider);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'No Signal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                // backgroundColor: NoSignalTheme.whiteShade1,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              PopupMenuButton(
                  onSelected: (PopupItem item) {
                    switch (item) {
                      case PopupItem.group:
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Wait '),
                        ));
                        break;
                      case PopupItem.settings:
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Stfu'),
                        ));
                        break;
                      case PopupItem.logout:
                        auth.logout(context);

                        break;
                    }
                  },
                  itemBuilder: (context) => <PopupMenuEntry<PopupItem>>[
                        const PopupMenuItem<PopupItem>(
                          value: PopupItem.group,
                          child: Text('New group'),
                        ),
                        const PopupMenuItem<PopupItem>(
                          value: PopupItem.settings,
                          child: Text('Settings'),
                        ),
                        const PopupMenuItem<PopupItem>(
                          value: PopupItem.logout,
                          child: Text('Logout'),
                        ),
                      ])
            ],
          ),
          SliverToBoxAdapter(
            child: ChatTileWidget(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(UsersListPage.routeName);
        },
        backgroundColor: NoSignalTheme.whiteShade1,
        mini: true,
        child: FaIcon(
          FontAwesomeIcons.pen,
          color: NoSignalTheme.navyblueshade4,
        ),
      ),
    );
  }
}
