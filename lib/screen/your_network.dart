import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '/api/profileDataApi.dart';
import '/module/connection.dart';
import 'package:flutter/material.dart';

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
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 4,
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
                                          "${snapshot.data!.data[index].firstName}"
                                          "${snapshot.data!.data[index].lastName}",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Row(children: [
                                        Icon(Icons.location_pin),
                                        Flexible(
                                            child: new Container(
                                          padding: new EdgeInsets.only(
                                              right: 1.0, left: 5),
                                          child: Text(
                                            snapshot
                                                .data!.data[index].college.name,
                                            overflow: TextOverflow.visible,
                                            style: TextStyle(
                                              fontSize: 19,
                                            ),
                                          ),
                                        )),
                                      ]),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                            'Friends',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'See All',
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        height: 85,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(),
                                                ),
                                                Text('Name')
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       padding: const EdgeInsets.all(6),
                                      //       margin: const EdgeInsets.all(8),
                                      //       width: MediaQuery.of(context)
                                      //                   .size
                                      //                   .width /
                                      //               2 -
                                      //           60,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.blue,
                                      //           shape: BoxShape.rectangle,
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(50))),
                                      //       child: Text(
                                      //         'Open to',
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //             color: Colors.white,
                                      //             fontSize: 22,
                                      //             fontWeight: FontWeight.bold),
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //       padding: const EdgeInsets.all(6),
                                      //       margin: const EdgeInsets.all(8),
                                      //       width: MediaQuery.of(context)
                                      //                   .size
                                      //                   .width /
                                      //               2 -
                                      //           25,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.white,
                                      //           shape: BoxShape.rectangle,
                                      //           boxShadow: [
                                      //             BoxShadow(
                                      //                 color: Colors.grey,
                                      //                 spreadRadius: .5)
                                      //           ],
                                      //           borderRadius: BorderRadius.all(
                                      //               Radius.circular(50))),
                                      //       child: Text(
                                      //         'Add section',
                                      //         textAlign: TextAlign.center,
                                      //         style: TextStyle(
                                      //             color: Colors.grey,
                                      //             fontSize: 22,
                                      //             fontWeight: FontWeight.bold),
                                      //       ),
                                      //     ),
                                      //     Container(
                                      //         padding: const EdgeInsets.all(6),
                                      //         margin: const EdgeInsets.all(8),
                                      //         width: 25,
                                      //         decoration: BoxDecoration(
                                      //           color: Colors.white,
                                      //           shape: BoxShape.circle,
                                      //           boxShadow: [
                                      //             BoxShadow(
                                      //                 color: Colors.grey,
                                      //                 spreadRadius: 1)
                                      //           ],
                                      //           // borderRadius: BorderRadius.all(Radius.circular(50))
                                      //         ),
                                      //         child: Icon(
                                      //           Icons.more_horiz,
                                      //           textDirection:
                                      //               TextDirection.rtl,
                                      //         )),
                                      //   ],
                                      // ),
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
                                        top: 130, left: 20, right: 20),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                  'assets/profile.png')),
                                          GestureDetector(
                                            dragStartBehavior:
                                                DragStartBehavior.down,
                                            onTap: () {},
                                            child: Container(
                                              // height: 35,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        spreadRadius: 1,
                                                        color: Colors.black12,
                                                        offset: Offset
                                                            .fromDirection(
                                                                0.9, 2.5),
                                                        blurRadius: 2.0)
                                                  ],
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                              margin: const EdgeInsets.only(
                                                  top: 60.0),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.grey,
                                                size: 30,
                                              ),
                                            ),
                                          )
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
