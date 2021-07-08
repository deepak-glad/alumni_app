import 'package:flutter/material.dart';

class RequestFriendList extends StatefulWidget {
  static const routeName = 'requestFriendslist';

  @override
  _RequestFriendListState createState() => _RequestFriendListState();
}

class _RequestFriendListState extends State<RequestFriendList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Connection Requests'),
      ),
      // body: FutureBuilder<Welcome>(future: _data,builder: (context,snashot){if(snashot.hasData)return },),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text('Name'),
            subtitle: Text('subdetails'),
            trailing: Icon(Icons.undo),
          )
        ],
      ),
    );
  }
}
