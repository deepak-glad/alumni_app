import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_appp/api/connection_api.dart';
import 'package:test_appp/sub_screen/search.dart';
import '/module/suggestion.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList>
// with AutomaticKeepAliveClientMixin<FriendsList> {

{
  late List<Datum> _freindsData = <Datum>[];
  late Future<FriendModel> _data;
  @override
  void initState() {
    _data = myFriendsList();
    _data.then((value) {
      _freindsData = value.data;
    });

    super.initState();
  }

  // @override
  // bool get wantKeepAlive => true;
  // final GlobalKey _menuKey = new GlobalKey();
  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _data = myFriendsList();
    });
  }

  var isUnfriend = false;

  _onsubmit(String friendId) async {
    setState(() {
      isUnfriend = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('token');

    var url = Uri.parse(
        'https://alumni-supervision.herokuapp.com/connect/unfriend/$friendId');
    http.Response response = await http.delete(url, headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: value.toString(),
    });
    print(response.body);

    var jsonResponse = json.decode(response.body);
    if (response.statusCode == 200 && jsonResponse['status']) {
      setState(() {
        isUnfriend = false;
      });
      var message = jsonResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
    } else {
      var message = jsonResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        isUnfriend = false;
      });
    }
    setState(() {
      isUnfriend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(_freindsData.first.firstName);
    // super.build(context);
    return Container(
      // color: Colors.amber,
      // padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 15, left: 2, right: 4),
      child: FutureBuilder<FriendModel>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: _onPull,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _freindsData.length,
                      itemBuilder: (context, index) {
                        var _apidata = _freindsData[index];
                        print(_freindsData
                            .map((e) => e.id)
                            .contains(_apidata.id));
                        var popupMenuButton = new PopupMenuButton(
                            itemBuilder: (_) => <PopupMenuItem>[
                                  new PopupMenuItem(
                                      child: GestureDetector(
                                          onTap: () {
                                            _onsubmit(_apidata.id);
                                            _freindsData
                                                    .map((e) => e.id)
                                                    .contains(_apidata.id)
                                                ? _freindsData.removeAt(index)
                                                : null;
                                          },
                                          child: isUnfriend
                                              ? CircularProgressIndicator()
                                              : const Text('Unfriend')),
                                      value: 'Unfriend'),
                                  new PopupMenuItem(
                                      child: const Text('Block'),
                                      value: 'Block'),
                                  new PopupMenuItem(
                                      child: const Text('Report'),
                                      value: 'Report'),
                                ],
                            onSelected: (_) {
                              // dynamic state = _menuKey.currentState;
                              // showButtonMenu();
                            });
                        return Column(children: [
                          Card(
                            child: ListTile(
                                isThreeLine: true,
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/profile1.jpg'),
                                  radius: 30,
                                ),
                                title: Text(
                                    '${_apidata.firstName} ${_apidata.lastName}'),
                                subtitle: Text(_apidata.college.name),
                                trailing: Container(
                                  width: 96,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.chat,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        popupMenuButton,
                                      ]),
                                )),
                          ),
                          Divider()
                        ]);
                      }),
                );
              } else {
                return Center(child: Image.asset('assets/nothing.png'));
              }
            } else if (snapshot.hasError) {
              return Center(child: Image.asset('assets/nothing.png'));
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
