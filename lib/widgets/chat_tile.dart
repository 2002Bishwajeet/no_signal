import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// [ChatTileWidget]
///
/// This widget will be displayed to show the past chat convo with the users
/// So this widget will be shown in the [HomePage]
class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(
            'https://images.pexels.com/photos/9226510/pexels-photo-9226510.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
      ),
      title: Text('Aishwarya'),
      subtitle: Text('Hey, how are you?'),
      trailing: Text('11:01 AM'),
    );
  }
}
