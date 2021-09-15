import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:no_signal/models/chat.dart';
import 'package:no_signal/models/user.dart';
import 'package:no_signal/providers/Auth.dart';
import 'package:no_signal/providers/chat.dart';
import 'package:no_signal/themes.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat';
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatBubble> _chatBubbles = [];
  final TextEditingController _textController = TextEditingController();
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

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
        body: Consumer(builder: (context, watch, _) {
          final chat = watch(chatProvider);
          final user = watch(authProvider).getAccount();
          Future<void> _sendMessage(String message) async {
            User? acc = await user;
            Chat data = Chat(
                senderName: acc!.name as String,
                senderid: acc.id,
                message: message,
                time: DateTime.now());

            try {
              await chat.sendMessage(data);
              _textController.clear();
            } catch (e) {
              print(e);
            }
          }

          return Scaffold(
            body: ListView(
              children: [
                ChatBubble(
                  margin: EdgeInsets.only(top: 10),
                  clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  backGroundColor: NoSignalTheme.lightBlueShade,
                  shadowColor: Colors.transparent,
                  child: Text('Hello'),
                ),
                ChatBubble(
                  margin: EdgeInsets.only(top: 10),
                  clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
                  backGroundColor: Colors.grey[700],
                  shadowColor: Colors.transparent,
                  alignment: Alignment.topLeft,
                  child: Text('Hey'),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 20),
                      child: TextFormField(
                        controller: _textController,
                        textCapitalization: TextCapitalization.sentences,
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
                  InkWell(
                    onTap: () {
                      _sendMessage(_textController.text);
                    },
                    child: CircleAvatar(
                        backgroundColor: NoSignalTheme.lightBlueShade,
                        radius: 22.0,
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
