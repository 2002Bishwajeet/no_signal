import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/Pages/LoginPage.dart';
import 'package:no_signal/Pages/WelcomePage.dart';
import 'package:no_signal/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'No Signal',
      themeMode: ThemeMode.dark,
      darkTheme: NoSignalTheme.darkTheme(context),
      theme: NoSignalTheme.lightTheme(context),
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
      routes: {
        LoginPage.routename: (context) => LoginPage(),
      },
    );
  }
}
