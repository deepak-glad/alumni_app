import 'dart:convert';
import 'dart:io';

import 'package:test_appp/api/addFriend_api.dart';
import 'package:test_appp/module/pendin_model.dart';

import '../api/connection_api.dart';
import '/module/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionSuggestion extends StatefulWidget {
  @override
  _ConnectionSuggestionState createState() => _ConnectionSuggestionState();
}

class _ConnectionSuggestionState extends State<ConnectionSuggestion>
// with AutomaticKeepAliveClientMixin<ConnectionSuggestion> {
{
  late Future<FriendModel> _data;
  bool isLoading = false;
  var add = '';
  @override
  void initState() {
    _data = connectionSuggestion();
    _pendintFriendRequest();
    super.initState();
  }

  var _friendData = [];

  // @override
  // bool get wantKeepAlive => true;

  Future<void> _pendintFriendRequest() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('token');
    var url =
        Uri.parse('https://alumni-supervision.herokuapp.com/connect/pending');
    http.Response response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: value.toString(),
    });
    var jsonResponse = json.decode(response.body);
    var dataa = Pending.fromJson(jsonResponse);
    setState(() {
      dataa.invitationSend.forEach((element) {
        _friendData.add(element.targetUser);
      });
    });
  }

  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _data = connectionSuggestion();
      _pendintFriendRequest();
    });
  }

  @override
  void dispose() {
    _friendData = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      margin: const EdgeInsets.only(top: 8, left: 2, right: 4, bottom: 5),
      child: FutureBuilder<FriendModel>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data.isNotEmpty) {
                return RefreshIndicator(
                  onRefresh: _onPull,
                  child: ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        var _apidata = snapshot.data!.data[index];
                        return Column(children: [
                          Card(
                            child: ListTile(
                              isThreeLine: true,
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/profile1.jpg'),
                                radius: 26,
                              ),
                              title: Text(
                                  '${_apidata.firstName} ${_apidata.lastName}'),
                              subtitle: Text(_apidata.college.name),
                              // trailing: TextButton(
                              //   child: Image.asset(
                              //     'assets/icon.png',
                              //     height: 25,
                              //     color: _friendData.contains(
                              //             snapshot.data!.data[index].id)
                              //         ? Colors.grey
                              //         : Colors.blue,
                              //   ),
                              //   onPressed: () {
                              trailing: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.person_add,
                                  // color: Colors.blue,
                                ),
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  elevation: 2,
                                  primary: Theme.of(context).canvasColor,
                                  onPrimary: _friendData.contains(
                                          snapshot.data!.data[index].id)
                                      ? Colors.blueGrey
                                      : Colors.blue,
                                  alignment: Alignment.center,
                                ),
                                label: _friendData
                                        .contains(snapshot.data!.data[index].id)
                                    ? Text('Pending')
                                    : Text('Add'),
                                onPressed: () {
                                  setState(() {
                                    _friendData.contains(
                                            snapshot.data!.data[index].id)
                                        ? _friendData.remove(
                                            snapshot.data!.data[index].id)
                                        : _friendData
                                            .add(snapshot.data!.data[index].id);
                                  });
                                  // var message = _friendData.contains(
                                  //         snapshot.data!.data[index].id)
                                  //     ? 'friend request send'
                                  //     : 'friend request withdraw';
                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   SnackBar(
                                  //     behavior: SnackBarBehavior.floating,
                                  //     duration: Duration(seconds: 2),
                                  //     content: Text(message),
                                  //     backgroundColor:
                                  //         Theme.of(context).primaryColor,
                                  //     action: SnackBarAction(
                                  //       label: 'X',
                                  //       onPressed: () {},
                                  //     ),
                                  //   ),
                                  // );
                                  onpress(
                                      snapshot.data!.data[index].id, context);
                                },
                              ),
                            ),
                          ),
                          Divider()
                        ]);
                      }),
                );
              } else {
                return Center(child: Image.asset('assets/nothing.png'));
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
