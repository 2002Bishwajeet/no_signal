import 'package:flutter/material.dart';
import 'package:no_signal/themes.dart';

class ChatPage extends StatelessWidget {
  static const String routeName = '/chat';
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: NoSignalTheme.navyblueshade4,
          leadingWidth: 20,
          elevation: 0,
          title: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/9226510/pexels-photo-9226510.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
              ),
            ),
            title: Text('Aishwarya'),
            subtitle: Text('Online'),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        body: Scaffold(
          body: Center(child: Text('Something')),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: TextFormField(
                      autocorrect: true,
                      enableIMEPersonalizedLearning: true,
                      enableInteractiveSelection: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusColor: NoSignalTheme.whiteShade1,
                        fillColor: NoSignalTheme.whiteShade1,
                        alignLabelWithHint: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: IconButton(
                          icon: Icon(Icons.insert_emoticon),
                          splashRadius: 10,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                    backgroundColor: NoSignalTheme.lightBlueShade,
                    radius: 22.0,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
