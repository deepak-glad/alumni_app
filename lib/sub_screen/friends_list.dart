import 'package:flutter/material.dart';
import 'package:test_appp/api/connection_api.dart';
import '/module/suggestion.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({Key? key}) : super(key: key);

  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList>
    with AutomaticKeepAliveClientMixin<FriendsList> {
  late Future<Welcome> _data;
  bool isLoading = false;
  var add = '';
  @override
  void initState() {
    _data = myFriendsList();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;
  final GlobalKey _menuKey = new GlobalKey();
  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _data = myFriendsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
        key: _menuKey,
        itemBuilder: (_) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                  child: const Text('Unfriend'), value: 'Unfriend'),
              new PopupMenuItem<String>(
                  child: const Text('Block'), value: 'Block'),
              new PopupMenuItem<String>(
                  child: const Text('Report'), value: 'Report'),
            ],
        onSelected: (_) {
          dynamic state = _menuKey.currentState;
          state.showButtonMenu();
        });

    super.build(context);
    return Container(
      // color: Colors.amber,
      // padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 15, left: 2, right: 4),
      child: FutureBuilder<Welcome>(
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
                                        button
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
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
