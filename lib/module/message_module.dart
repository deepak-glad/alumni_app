import 'package:flutter/cupertino.dart';

class Message {
  final String data;
  final bool isMe;

  Message(this.data, this.isMe);
}

class MessageProvider with ChangeNotifier {
  final List<Message> _list = [Message('hello', true), Message('hiiii', false)];
  List<Message> get data {
    return [..._list];
  }
}
