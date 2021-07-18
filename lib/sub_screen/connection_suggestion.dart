import 'dart:convert';
import 'dart:io';

import '/api/connectionSuggestion_api.dart';
import '/module/suggestion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/module/home_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConnectionSuggestion extends StatefulWidget {
  @override
  _ConnectionSuggestionState createState() => _ConnectionSuggestionState();
}

class _ConnectionSuggestionState extends State<ConnectionSuggestion> {
  late Future<Welcome> _data;
  bool isLoading = false;
  var add = '';
  @override
  void initState() {
    _data = connectionSuggestion();
    super.initState();
  }

  _onpress(String id) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('token');
    var url = Uri.parse(
        'https://alumni-supervision.herokuapp.com/connect/addFriend/$id');
    http.Response response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: value.toString(),
    });
    var jsonResponse = json.decode(response.body);
    // print(id);
    // print(response.body);
    if (response.statusCode == 200 && jsonResponse['status']) {
      setState(() {
        add = id;
      });
      var message = 'successfull';
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } else {
      var message = jsonResponse["message"];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Container(
      // color: Colors.amber,
      // padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 8, left: 2, right: 4),
      child: FutureBuilder<Welcome>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return
                  //   GridView.builder(
                  //       physics: NeverScrollableScrollPhysics(),
                  //       shrinkWrap: true,
                  //       itemCount: snapshot.data!.data.length,
                  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //           //  maxCrossAxisExtent: 200,
                  //           childAspectRatio: 4 / 5,
                  //           crossAxisSpacing: 8,
                  //           mainAxisSpacing: 5,
                  //           crossAxisCount:
                  //               (orientation == Orientation.portrait) ? 2 : 3),
                  //       itemBuilder: (context, index) {
                  //         return Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(20),
                  //             boxShadow: [BoxShadow(color: Colors.black26)],
                  //           ),
                  //           margin: const EdgeInsets.all(8),
                  //           child: Stack(
                  //             alignment: AlignmentDirectional.topCenter,
                  //             children: [
                  //               Column(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   Image.asset(
                  //                     // snapshot.data!.data[index].mediaUrl == null
                  //                     // ?
                  //                     'assets/profile1.jpg',
                  //                     // : snapshot.data!.data[index].mediaUrl,
                  //                     height: 80,
                  //                     width: 180,
                  //                     fit: BoxFit.fitWidth,
                  //                   ),
                  //                   SizedBox(height: 25),
                  //                   Expanded(
                  //                     child: Text(
                  //                       '${snapshot.data!.data[index].firstName} ${snapshot.data!.data[index].lastName}',
                  //                       textAlign: TextAlign.center,
                  //                       overflow: TextOverflow.fade,
                  //                       style: TextStyle(
                  //                           fontWeight: FontWeight.bold, fontSize: 18),
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     snapshot.data!.data[index].college.name,
                  //                     textAlign: TextAlign.center,
                  //                   ),
                  //                   snapshot.data!.data[index].id == add
                  //                       ? FlatButton.icon(
                  //                           shape: RoundedRectangleBorder(
                  //                               side: BorderSide(
                  //                                   color:
                  //                                       Theme.of(context).primaryColor),
                  //                               borderRadius:
                  //                                   new BorderRadius.circular(28.0)),
                  //                           minWidth: 150,
                  //                           height: 30,
                  //                           color: Theme.of(context).canvasColor,
                  //                           icon: Icon(Icons.send),
                  //                           label: Text('Pending',
                  //                               style: TextStyle(
                  //                                   color:
                  //                                       Theme.of(context).primaryColor,
                  //                                   fontSize: 18)),
                  //                           onPressed: () {
                  //                             _onpress(snapshot.data!.data[index].id);
                  //                           })
                  //                       :
                  //                       // ignore: deprecated_member_use
                  //                       FlatButton(
                  //                           shape: RoundedRectangleBorder(
                  //                               borderRadius:
                  //                                   new BorderRadius.circular(28.0)),
                  //                           minWidth: 150,
                  //                           height: 30,
                  //                           color: Theme.of(context).primaryColor,
                  //                           child: Text('Connect',
                  //                               style: TextStyle(
                  //                                   color: Colors.white, fontSize: 18)),
                  //                           onPressed: () {
                  //                             _onpress(snapshot.data!.data[index].id);
                  //                           })
                  //                 ],
                  //               ),
                  //               Container(
                  //                 height: 85,
                  //                 width: 80,
                  //                 margin: const EdgeInsets.only(top: 25),
                  //                 child: CircleAvatar(
                  //                   // foregroundImage:
                  //                   //     NetworkImage(snapshot.data.data[index].mediaUrl),
                  //                   radius: 60.0,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       });
                  // }
                  ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        var _apidata = snapshot.data!.data[index];
                        return Column(children: [
                          Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/profile1.jpg'),
                                radius: 26,
                              ),
                              title: Text(
                                  '${_apidata.firstName} ${_apidata.lastName}'),
                              subtitle: Text(_apidata.college.name),
                              trailing: TextButton(
                                child: Image.asset(
                                  'assets/icon.png',
                                  height: 25,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Divider()
                        ]);
                      });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
