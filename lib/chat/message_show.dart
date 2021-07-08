import 'package:flutter/material.dart';

class MessageShow extends StatelessWidget {
  final String message;
  final bool isMe;
  // final Key key;
  final String username;
  final String userImage;

  MessageShow(
    this.message,
    this.isMe,
    this.username,
    this.userImage,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          CircleAvatar(
            // child: Image.network(userImage),
            backgroundImage: AssetImage(userImage),
            backgroundColor: Colors.grey,
            // radius: ,
          ),
          Container(
            decoration: BoxDecoration(
                color: isMe
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: !isMe ? Radius.circular(0) : Radius.circular(12),
                )),
            width: 140,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe
                        ? Colors.black
                        // ignore: deprecated_member_use
                        : Theme.of(context).accentTextTheme.headline1!.color,
                  ),
                ),
                Text(
                  message,
                  style: TextStyle(
                    color: isMe
                        ? Colors.black
                        // ignore: deprecated_member_use
                        : Theme.of(context).accentTextTheme.headline1!.color,
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
