import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/Pages/ErrorPage.dart';
import 'package:no_signal/Pages/HomePage.dart';
import 'package:no_signal/Pages/LoginPages/LoginPage.dart';
import 'package:no_signal/Pages/LoginPages/SignUpPage.dart';
import 'package:no_signal/Pages/WelcomePage.dart';
import 'package:no_signal/Pages/chatPage.dart';
import 'package:no_signal/Pages/loadingpage.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    final user = ref(userProvider);
    return MaterialApp(
      title: 'No Signal',
      themeMode: ThemeMode.dark,
      darkTheme: NoSignalTheme.darkTheme(context),
      theme: NoSignalTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      home: user.when(
          data: (data) {
            if (data == true)
              return HomePage();
            else
              return WelcomePage();
          },
          loading: () => LoadingPage(),
          error: (e, trace) => ErrorPage(error: e)),
      routes: {
        LoginPage.routename: (context) => LoginPage(),
        HomePage.routename: (context) => HomePage(),
        CreateAccountPage.routeName: (context) => CreateAccountPage(),
        ChatPage.routeName: (context) => ChatPage(),
      },
    );
  }
}
