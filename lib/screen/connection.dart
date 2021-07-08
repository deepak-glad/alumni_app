import '/screen/friendsList.dart';
import '/screen/requestFriendList.dart';
import '/sub_screen/connection_suggestion.dart';
import 'package:flutter/material.dart';

class ConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Manage your network',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushNamed(FriendsList.routeName);
                },
              ),
              Container(
                height: 5,
                color: Colors.grey[200],
              ),
              ListTile(
                title: Text(
                  'Invitations',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 20),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).pushNamed(RequestFriendList.routeName);
                },
              ),
              Container(
                height: 5,
                color: Colors.grey[200],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Industry leaders in India you may know',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ConnectionSuggestion(),
            ],
          ),
        ),
      ),
    );
  }
}
