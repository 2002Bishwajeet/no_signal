import 'package:flutter/material.dart';

class ChatTileWidget extends StatelessWidget {
  const ChatTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/9226510/pexels-photo-9226510.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
      ),
      title: Text('Aishwarya'),
      subtitle: Text('Hey, how are you?'),
      trailing: Text('11:01 AM'),
      onTap: () {
        Navigator.of(context).pushNamed('/chat');
      },
      onLongPress: () {},
    );
  }
}
