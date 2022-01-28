import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/themes.dart';

import 'pages/chat_page.dart';
import 'pages/home_page.dart';
import 'pages/loading_page.dart';
import 'pages/login/login_page.dart';
import 'pages/login/create_profile.dart';
import 'pages/popup/settings.dart';
import 'pages/userslist_page.dart';
import 'pages/welcome_page.dart';

void main() {
  //  to ensure widgets are glued properly
  WidgetsFlutterBinding.ensureInitialized();
  //  provider scope is nessary to access the all the providers
  runApp(const ProviderScope(child: MainApp()));
}

//  I used a stateful widget so that I can use the initState method
//  to check if the user is logged in or not
//  and then decide the course of action
class MainApp extends ConsumerStatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  Future<void> _init(WidgetRef ref) async {
    //  This is how you can access providers in stateful widgets
    final user = await ref.read(authProvider).getAccount();
    if (user != null) {
      //  This is how you can modify the state of the providers
      ref.read(userLoggedProvider.state).state = user;
      ref.read(userLoggedInProvider.state).state = true;
    } else {
      ref.read(userLoggedInProvider.state).state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _init(ref);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Signal',
      themeMode: ThemeMode.dark,
      darkTheme: NoSignalTheme.darkTheme(),
      theme: NoSignalTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: const AuthChecker(),
      routes: {
        LoginPage.routename: (context) => const LoginPage(),
        HomePage.routename: (context) => const HomePage(),
        CreateAccountPage.routeName: (context) => const CreateAccountPage(),
        ChatPage.routeName: (context) => ChatPage(),
        UsersListPage.routeName: (context) => const UsersListPage(),
        SettingsScreen.routename: (context) => const SettingsScreen(),
      },
    );
  }
}

//   This is authchecker widget which is used to check if the user is logged in or not
//  since it depends on state we do not need to use navigator to route to widgets
//  it will automatically change acc to the state
class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

//  So here's the thing what we have done
//  if the _isLoggedIn is true, we will go to Home Page
//  if false we will go to Welcome Page
// and if the user is null we will show a Loading screen
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isLoggedIn = ref.watch(userLoggedInProvider.state).state;
    if (_isLoggedIn == true) {
      return const HomePage(); // It's asimple basic screen showing the home page with welcome message
    } else if (_isLoggedIn == false) {
      return const WelcomePage(); // It's the intro screen we made
    }
    return const LoadingPage(); // It's a plain screen with a circular progress indicator in Center
  }
}


