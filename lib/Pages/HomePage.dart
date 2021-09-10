import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/themes.dart';

class HomePage extends ConsumerWidget {
  static const routename = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader ref) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        title: Text('No Signal'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: NoSignalTheme.whiteShade1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert_rounded),
            onPressed: () {},
          ),
        ],
      )
    ]));
  }
}
