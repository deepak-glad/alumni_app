import 'package:flutter/material.dart';

class MessageSend extends StatefulWidget {
  @override
  _MessageSendState createState() => _MessageSendState();
}

class _MessageSendState extends State<MessageSend> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';
  _sendMessage() async {
    FocusScope.of(context).unfocus();
    print(_enteredMessage);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: MediaQuery.of(context).size.width,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.add_circle)),
            IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
            Expanded(
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                minLines: 1,
                maxLines: 7,
                decoration:
                    InputDecoration(hintText: 'Enter message to send  '),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
            _controller.text.isNotEmpty
                ? IconButton(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  )
                : IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {},
                  )
          ]),
    );
  }
}
