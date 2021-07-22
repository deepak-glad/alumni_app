import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:test_appp/api/addFriend_api.dart';
import 'package:test_appp/api/connection_api.dart';
import 'package:test_appp/module/pendin_model.dart';

class PendingFriendsList extends StatefulWidget {
  const PendingFriendsList({Key? key}) : super(key: key);

  @override
  _PendingFriendsListState createState() => _PendingFriendsListState();
}

class _PendingFriendsListState extends State<PendingFriendsList>
// with AutomaticKeepAliveClientMixin<PendingFriendsList> {
{
  // @override
  // bool get wantKeepAlive => true;

  late Future<Pending> _future;
  late List<Invita> _receivedFriendSent = <Invita>[];
  late List<Invita> _receivedFriendReceived = <Invita>[];
  @override
  void initState() {
    _future = mypendingREquest();
    _future.then((value) {
      setState(() {
        _receivedFriendSent = value.invitationSend;
        _receivedFriendReceived = value.invitaionReceived;
      });
    });
    super.initState();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _future.then((value) {
      setState(() {
        _receivedFriendSent = value.invitationSend;
        _receivedFriendReceived = value.invitaionReceived;
      });
    });
    setState(() {
      _future = mypendingREquest();
    });
  }

  @override
  Widget build(BuildContext contextt) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 2, right: 4, bottom: 5),
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: _onPull,
                  child: ListView(shrinkWrap: true,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_receivedFriendReceived.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Invitations Received:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _receivedFriendReceived.length,
                            itemBuilder: (context, index) {
                              var _apidata = _receivedFriendReceived[index];

                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                        child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                'assets/profile1.jpg',
                                              ),
                                              radius: 35,
                                            ),
                                            title: Text(
                                                '${_apidata.user.firstName} ${_apidata.user.lastName}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 19)),

                                            // title: RichText(
                                            //   text: TextSpan(
                                            //     text: '',
                                            //     style: TextStyle(
                                            //         color: Colors.black, fontSize: 19),
                                            //     children: <TextSpan>[
                                            //       TextSpan(
                                            //         text:
                                            //             '${_apidata.target.firstName} ${_apidata.target.lastName} ',
                                            //         style: TextStyle(
                                            //           color: Colors.black,
                                            //           fontWeight: FontWeight.bold,
                                            //           // decoration: TextDecoration.underline,
                                            //           decorationStyle:
                                            //               TextDecorationStyle.wavy,
                                            //         ),
                                            //         // recognizer: _longPressRecognizer,
                                            //       ),
                                            //       TextSpan(
                                            //           text: ' sent to connection request',
                                            //           style: TextStyle(
                                            //             fontWeight: FontWeight.normal,
                                            //             fontSize: 18,
                                            //           )),
                                            //     ],
                                            //   ),
                                            // ),
                                            subtitle: Text(
                                                '${_apidata.createdAt.minute.toString()} min'),
                                            trailing: SizedBox(
                                              width: 110,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 32,
                                                      width: 55,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: CircleBorder(),
                                                          elevation: 2,
                                                          alignment:
                                                              Alignment.center,
                                                          primary:
                                                              Colors.green[100],
                                                          onPrimary:
                                                              Colors.white,
                                                        ),
                                                        child: Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        onPressed: () {
                                                          addFriend(_apidata.id,
                                                              contextt, true);

                                                          setState(() {
                                                            _receivedFriendReceived
                                                                    .map((e) =>
                                                                        e.id)
                                                                    .contains(
                                                                        _apidata
                                                                            .id)
                                                                ? _receivedFriendReceived
                                                                    .removeAt(
                                                                        index)
                                                                : null;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 32,
                                                      width: 55,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: CircleBorder(),
                                                          elevation: 2,
                                                          alignment:
                                                              Alignment.center,
                                                          primary:
                                                              Colors.red[100],
                                                          onPrimary:
                                                              Colors.white,
                                                        ),
                                                        child: Icon(
                                                          Icons.close_rounded,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {
                                                          addFriend(_apidata.id,
                                                              contextt, false);
                                                          setState(() {
                                                            _receivedFriendReceived
                                                                    .map((e) =>
                                                                        e.id)
                                                                    .contains(
                                                                        _apidata
                                                                            .id)
                                                                ? _receivedFriendReceived
                                                                    .removeAt(
                                                                        index)
                                                                : null;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ]),
                                            ))),
                                    Divider()
                                  ]);
                            }),
                        if (_receivedFriendSent.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Invitations Send:',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _receivedFriendSent.length,
                            itemBuilder: (context, index) {
                              var _apidata = _receivedFriendSent[index];

                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                        child: ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/profile1.jpg'),
                                              radius: 26,
                                            ),
                                            title: Text(
                                              '${_apidata.target.firstName} ${_apidata.target.lastName}',
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            subtitle: Text(
                                                '${_apidata.createdAt.minute} min'),
                                            trailing: SizedBox(
                                                height: 32,
                                                width: 55,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: CircleBorder(),
                                                    elevation: 2,
                                                    alignment: Alignment.center,
                                                    primary: Colors.red[100],
                                                    onPrimary: Colors.white,
                                                  ),
                                                  child: Icon(
                                                    Icons.logout_rounded,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    onpress(_apidata.targetUser,
                                                        contextt);
                                                    setState(() {
                                                      _receivedFriendSent
                                                              .map((e) =>
                                                                  e.targetUser)
                                                              .contains(_apidata
                                                                  .targetUser)
                                                          ? _receivedFriendSent
                                                              .removeAt(index)
                                                          : null;
                                                    });
                                                  },
                                                )))),
                                    Divider()
                                  ]);
                            }),
                        if (_receivedFriendReceived.isEmpty &&
                            _receivedFriendSent.isEmpty)
                          Center(
                            child: Image.asset('assets/nothing.png'),
                          )
                      ]),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
