import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_appp/api/addFriend_api.dart';
import 'package:test_appp/api/connection_api.dart';
import 'package:test_appp/module/pendin_model.dart';

class PendingFriendsList extends StatefulWidget {
  const PendingFriendsList({Key? key}) : super(key: key);

  @override
  _PendingFriendsListState createState() => _PendingFriendsListState();
}

class _PendingFriendsListState extends State<PendingFriendsList>
    with AutomaticKeepAliveClientMixin<PendingFriendsList> {
  @override
  bool get wantKeepAlive => true;

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
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _onPull,
      child: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.only(top: 8, left: 2, right: 4, bottom: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (_receivedFriendReceived.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Invitations Received:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                    backgroundImage:
                                        AssetImage('assets/profile1.jpg'),
                                    radius: 26,
                                  ),
                                  title: Text(
                                      '${_apidata.target.firstName} ${_apidata.target.firstName}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add_box),
                                    onPressed: () {
                                      addFriend(_apidata.id, context);

                                      setState(() {
                                        _receivedFriendReceived
                                                .map((e) => e.id)
                                                .contains(_apidata.id)
                                            ? _receivedFriendSent
                                                .removeAt(index)
                                            : null;
                                      });
                                    },
                                  ))),
                          Divider()
                        ]);
                  }),
              if (_receivedFriendSent.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Invitations Send:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                    backgroundImage:
                                        AssetImage('assets/profile1.jpg'),
                                    radius: 26,
                                  ),
                                  title: Text(
                                      '${_apidata.target.firstName} ${_apidata.target.firstName}'),
                                  trailing: IconButton(
                                    onPressed: () {
                                      onpress(_apidata.user, context);
                                      setState(() {
                                        _receivedFriendSent
                                                .map((e) => e.user)
                                                .contains(_apidata.user)
                                            ? _receivedFriendSent
                                                .removeAt(index)
                                            : null;
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle),
                                  ))),
                          Divider()
                        ]);
                  }),
              if (_receivedFriendReceived.isEmpty &&
                  _receivedFriendSent.isEmpty)
                Center(
                  child: Image.asset('assets/nothing.png'),
                )
            ])),
      ),
    );
  }
}
