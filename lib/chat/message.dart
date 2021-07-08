import '/chat/message_send.dart';
import '/chat/message_show.dart';
import '/module/message_module.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatelessWidget {
  static const routeName = 'message-screen';
  final String name;
  final String profileImage;
  final String status;
  MessageScreen(this.name, this.profileImage, this.status);
  @override
  Widget build(BuildContext context) {
    var messageData = Provider.of<MessageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {},
          child: Text(name,
              style: TextStyle(color: Theme.of(context).primaryColor)),
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          // Text(name,
          //     style: TextStyle(color: Theme.of(context).primaryColor)),
          //     Text('last seen 4:55 pm',
          //         style: TextStyle(
          //             color: Theme.of(context).accentColor,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w400))
          //   ],
          // ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_sharp))
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: Container(
        // color: Colors.yellow,
        // padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 15),

        child: Column(children: [
          CircleAvatar(
            foregroundImage: AssetImage(profileImage),
          ),
          Text(name),
          Text(status),
          Divider(color: Colors.black),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: messageData.data.length,
                itemBuilder: (context, index) {
                  var predata = messageData.data[index];
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MessageShow(
                          predata.data, predata.isMe, name, profileImage),
                      SizedBox(height: 50),
                    ],
                  );
                }),
          ),
        ]),
      ),
      bottomSheet: MessageSend(),
    );
  }
}
