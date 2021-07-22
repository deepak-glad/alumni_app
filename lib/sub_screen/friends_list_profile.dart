import 'package:flutter/material.dart';
import 'package:test_appp/api/connection_api.dart';
import 'package:test_appp/module/suggestion.dart';

class FriendsListProfile extends StatefulWidget {
  const FriendsListProfile({Key? key}) : super(key: key);

  @override
  _FriendsListProfileState createState() => _FriendsListProfileState();
}

class _FriendsListProfileState extends State<FriendsListProfile> {
  late Future<FriendModel> _data;
  @override
  void initState() {
    _data = myFriendsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<FriendModel>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.data.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(),
                        ),
                        Text(snapshot.data!.data[index].firstName)
                      ],
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
