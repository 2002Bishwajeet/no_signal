import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:no_signal/Pages/popup/settings.dart';
import 'package:no_signal/Pages/userslist_page.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/providers/user_data.dart';
import 'package:no_signal/themes.dart';

// PopupItems
enum PopupItem {
  group,
  settings,
  logout,
}

class HomePage extends ConsumerWidget {
  static const routename = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Authentication variable to implement logout functionality
    final auth = ref.watch(authProvider);

    // User data variable to get user $id to get the image preview
    final user = ref.watch(userLoggedProvider)!.$id;

    //  Final Image to display in the appBar
    final img = ref.watch(imageUrlProvider(user)).asData?.value;

    //  This time I decided to work with [SLIVERS] instead of [LIST]
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text(
              'No Signal',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  // Open Settings screen
                  Navigator.of(context)
                      .pushNamed(SettingsScreen.routename, arguments: img);
                },
                child: CircleAvatar(
                  backgroundImage: img != null
                      ? MemoryImage(img) as ImageProvider
                      : const AssetImage('assets/images/avatar.png'),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              PopupMenuButton(
                  onSelected: (PopupItem item) {
                    switch (item) {
                      case PopupItem.group:
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Wait '),
                          // Will Implement later
                        ));
                        break;
                      case PopupItem.settings:
                      // Open settings screen
                        Navigator.of(context).pushNamed(
                            SettingsScreen.routename,
                            arguments: img);
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
          // We will implement more logic later
          //  Currently we are using cause the Home Page has no chat list
          SliverFillRemaining(
            child: Center(
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.subtitle1,
                    children: const [
                      TextSpan(
                        text: 'Press ',
                      ),
                      WidgetSpan(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        child: FaIcon(
                          FontAwesomeIcons.pen,
                          size: 16,
                        ),
                      )),
                      TextSpan(
                        text: ' Icon to chat ',
                      ),
                    ]),
              ),
            ),
          )
          // const SliverToBoxAdapter(
          //   child: ChatTileWidget(),
          // )
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
