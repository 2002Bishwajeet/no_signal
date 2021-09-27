import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/Pages/HomePage.dart';
import 'package:no_signal/Pages/LoginPages/LoginPage.dart';
import 'package:no_signal/Pages/LoginPages/SignUpPage.dart';
import 'package:no_signal/Pages/WelcomePage.dart';
import 'package:no_signal/Pages/chatPage.dart';
import 'package:no_signal/Pages/loadingpage.dart';
import 'package:no_signal/Pages/usersListPage.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> _init() async {
    final user = await context.read(authProvider).getAccount();
    if (user != null) {
      context.read(userLoggedProvider).state = user;
      context.read(userLoggedInProvider).state = true;
    } else {
      context.read(userLoggedInProvider).state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Signal',
      themeMode: ThemeMode.dark,
      darkTheme: NoSignalTheme.darkTheme(context),
      theme: NoSignalTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
      routes: {
        LoginPage.routename: (context) => LoginPage(),
        HomePage.routename: (context) => HomePage(),
        CreateAccountPage.routeName: (context) => CreateAccountPage(),
        ChatPage.routeName: (context) => ChatPage(),
        UsersListPage.routeName: (context) => UsersListPage(),
      },
    );
  }
}

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _isLoggedIn = watch(userLoggedInProvider).state;
    if (_isLoggedIn == true) {
      return HomePage();
    } else if (_isLoggedIn == false) {
      return WelcomePage();
    }
    return LoadingPage();
  }
}
