import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:test_appp/api/connection_api.dart';
import 'package:test_appp/module/suggestion.dart';
import 'package:test_appp/screen/myfriends_profile_full.dart';
import 'package:test_appp/sub_screen/friends_list_profile.dart';

import '/api/profileDataApi.dart';
import '/module/connection.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';

class YourNetworkScreen extends StatefulWidget {
  @override
  _YourNetworkScreenState createState() => _YourNetworkScreenState();
}

class _YourNetworkScreenState extends State<YourNetworkScreen> {
  late Future<Welcome> _data;

  @override
  void initState() {
    _data = profileDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder<Welcome>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            color: Colors.white,
                            child: Stack(
                              // alignment: AlignmentDirectional.topStart,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                                  4 -
                                              35,
                                      width: MediaQuery.of(context).size.width,
                                      // child: Image.network(
                                      //   snapshot.data!.data[index].mediaUrl,
                                      //   fit: BoxFit.cover,
                                      // ),
                                      child: Image.asset(
                                        'assets/profile2.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.camera_enhance))
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 180),
                                  padding: const EdgeInsets.only(
                                      top: 50, left: 10, right: 10),
                                  decoration: BoxDecoration(color: Colors.white,
                                      // borderRadius: BorderRadius.all(),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          spreadRadius: 2.0,
                                        )
                                      ]),
                                  // padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "${snapshot.data!.data[index].firstName} ${snapshot.data!.data[index].lastName}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      new Container(
                                        padding: new EdgeInsets.only(
                                            right: 2.0, bottom: 2),
                                        child: Text(
                                          snapshot
                                              .data!.data[index].college.name,
                                          overflow: TextOverflow.visible,
                                          style: TextStyle(
                                            fontSize: 19,
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2.0, vertical: 8),
                                        child: Text(
                                          'Description about jobs all the description that gona display herre and som other occupation and qulification about their features',
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '44',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text('Post'),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '44',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text('Post'),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '44',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 24),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text('Post'),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Connections',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  MyFriendsProfile.routename);
                                            },
                                            child: Text('See All',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                          )
                                        ],
                                      ),
                                      FriendsListProfile(),
                                      Divider(),
                                      ListTile(
                                        leading: Icon(Icons.feed),
                                        title: Text('Activity'),
                                        subtitle: Text('start a post'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {},
                                      ),
                                      ListTile(
                                        leading:
                                            Icon(Icons.connect_without_contact),
                                        title: Text('Connections'),
                                        subtitle: Text(
                                            'see total connections you may know'),
                                        trailing: Icon(Icons.arrow_forward_ios),
                                        onTap: () {},
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    // color: Colors.amber,
                                    // width: 100,
                                    alignment: Alignment.bottomLeft,
                                    margin: const EdgeInsets.only(
                                        top: 100, left: 20, right: 2),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              //for profile image change
                                            },
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              spreadRadius: 2.5,
                                                              blurRadius: 1,
                                                              color:
                                                                  Colors.white)
                                                        ]),
                                                    child: CircleAvatar(
                                                      radius: 63,
                                                      backgroundImage: AssetImage(
                                                          'assets/profile1.jpg'),
                                                    ),
                                                  ),
                                                  Container(
                                                    // height: 35,
                                                    padding:
                                                        const EdgeInsets.all(7),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              spreadRadius: 1,
                                                              color: Colors
                                                                  .black12,
                                                              offset: Offset
                                                                  .fromDirection(
                                                                      0.9, 2.5),
                                                              blurRadius: 2.0)
                                                        ],
                                                        shape: BoxShape.circle,
                                                        color: Colors.white),

                                                    child: Icon(Icons.add,
                                                        color: Colors.black,
                                                        size: 17),
                                                  ),
                                                ]),
                                          ),
                                          // GestureDetector(
                                          //   dragStartBehavior:
                                          //       DragStartBehavior.down,
                                          //   onTap: () {
                                          //     Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //             builder: (BuildContext
                                          //                     context) =>
                                          //                 ProfileEdit()));
                                          //   },
                                          //   child: Container(
                                          //     // height: 35,
                                          //     padding: const EdgeInsets.all(8),
                                          //     decoration: BoxDecoration(
                                          //         boxShadow: [
                                          //           BoxShadow(
                                          //               spreadRadius: 1,
                                          //               color: Colors.black12,
                                          //               offset: Offset
                                          //                   .fromDirection(
                                          //                       0.9, 2.5),
                                          //               blurRadius: 2.0)
                                          //         ],
                                          //         shape: BoxShape.circle,
                                          //         color: Colors.white),
                                          //     margin: const EdgeInsets.only(
                                          //         top: 60.0),
                                          //     child: Icon(
                                          //       Icons.add,
                                          //       color: Colors.grey,
                                          //       size: 30,
                                          //     ),
                                          //   ),
                                          // )

                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              ProfileEdit()));
                                                },
                                                icon: Icon(Icons
                                                    .mode_edit_outline_outlined)),
                                          ),
                                        ])),
                              ],
                            ));
                      });
                else
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ));
              })),
    );
  }
}
