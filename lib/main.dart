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
  //  to ensure widgets are glued properly
  WidgetsFlutterBinding.ensureInitialized();
  //  provider scope is nessary to access the all the providers
  runApp(ProviderScope(child: MainApp()));
}

//  I used a stateful widget so that I can use the initState method
//  to check if the user is logged in or not
//  and then decide the course of action
class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Future<void> _init() async {
    //  This is how you can access providers in stateful widgets
    final user = await context.read(authProvider).getAccount();
    if (user != null) {
      //  This is how you can modify the state of the providers
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
  Widget build(BuildContext context, ScopedReader watch) {
    final _isLoggedIn = watch(userLoggedInProvider).state;
    if (_isLoggedIn == true) {
      return HomePage(); // It's asimple basic screen showing the home page with welcome message
    } else if (_isLoggedIn == false) {
      return WelcomePage(); // It's the intro screen we made
    }
    return LoadingPage(); // It's a plain screen with a circular progress indicator in Center
  }
}
