import 'package:flutter/material.dart';

import '../themes.dart';

/// [SendMessageWidget]
///
/// A Custom widget with TextField and Send Button
class SendMessageWidget extends StatelessWidget {
  final VoidCallback? onSend;
  const SendMessageWidget({
    Key? key,
    this.onSend,
    required TextEditingController textController,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: TextFormField(
                controller: _textController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableIMEPersonalizedLearning: true,
                enableInteractiveSelection: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusColor: NoSignalTheme.whiteShade1,
                  fillColor: NoSignalTheme.whiteShade1,
                  alignLabelWithHint: true,
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.insert_emoticon),
                    splashRadius: 10,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: onSend,
            child: CircleAvatar(
                backgroundColor: NoSignalTheme.lightBlueShade,
                radius: 22.0,
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
