import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/providers/Auth.dart';

class HomePage extends ConsumerWidget {
  static const routename = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    final func = ref(authProvider);
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Sign out"),
          onPressed: () async {
            func.logout(context);
           
          },
        ),
      ),
    );
  }
}
