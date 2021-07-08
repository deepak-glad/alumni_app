import '/api/friendsList_api.dart';
import '/module/friendsList_model.dart';
import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  static const routeName = 'friendsList';

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  late Future<Welcome> _data;
  @override
  void initState() {
    _data = friendsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connection'),
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
