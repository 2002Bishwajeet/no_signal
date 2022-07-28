import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:no_signal/api/auth/authentication.dart';
import 'package:no_signal/pages/home/users_list_page.dart';
import 'package:no_signal/pages/login/login_page.dart';
import 'package:no_signal/providers/auth.dart';
import 'package:no_signal/providers/user_data.dart';
import 'package:no_signal/themes.dart';

import '../../models/popup.dart';
import '../settings/settings.dart';

class HomePage extends ConsumerStatefulWidget {
  static const routename = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //
  // Authentication variable to implement logout functionality
  late final Authentication auth = ref.watch(authProvider);

  /// This function show errors caught by api
  void _showError(String error) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Something went wrong'),
        content: Text(error),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }

  /// Logout current user
  Future<void> _userLogout() async {
    //
    try {
      //
      await auth.logout();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Logged out Successfully"),
        duration: Duration(seconds: 2),
      ));

      await Navigator.of(context).pushReplacementNamed(LoginPage.routename);
      //
    } on AppwriteException catch (e) {
      //
      _showError(e.message!);
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    //
    /// Get the current loggedIn User
    final currUser = ref.watch(currentLoggedUserProvider);
    //  This time I decided to work with [SLIVERS] instead of [LIST]
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
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
                  Navigator.of(context).pushNamed(SettingsScreen.routename);
                },
                child: CircleAvatar(
                  backgroundImage: currUser?.image != null
                      ? MemoryImage(currUser!.image!) as ImageProvider
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
                    case PopupItem.GROUP:
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Wait '),
                        // Will Implement later
                      ));
                      break;
                    case PopupItem.SETTINGS:
                      // Open settings screen
                      Navigator.of(context).pushNamed(SettingsScreen.routename);
                      break;
                    case PopupItem.LOGOUT:
                      _userLogout();

                      break;
                  }
                },
                itemBuilder: (context) => <PopupMenuEntry<PopupItem>>[
                  const PopupMenuItem<PopupItem>(
                    value: PopupItem.GROUP,
                    child: Text('New group'),
                  ),
                  const PopupMenuItem<PopupItem>(
                    value: PopupItem.SETTINGS,
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem<PopupItem>(
                    value: PopupItem.LOGOUT,
                    child: Text('Logout'),
                  ),
                ],
              )
            ],
          ),
          // We will implement more logic later
          SliverFillRemaining(
            hasScrollBody: false,
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
