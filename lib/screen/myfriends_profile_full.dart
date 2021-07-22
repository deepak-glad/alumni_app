import 'package:flutter/material.dart';
import 'package:test_appp/sub_screen/friends_list.dart';
import 'package:test_appp/sub_screen/search.dart';

class MyFriendsProfile extends StatelessWidget {
  const MyFriendsProfile({Key? key}) : super(key: key);
  static const routename = 'MyfriendsProfile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Connections')),
        body: Column(children: [
          GestureDetector(
            onTap: () {
              showSearch(context: context, delegate: DataSearch());
            },
            child: Container(
              margin: const EdgeInsets.all(15),
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  shape: BoxShape.rectangle,
                  color: Colors.grey[200]),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '      search',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          FriendsList()
        ]));
  }
}
