import '../api/addPost_APi.dart';
import '/screen/chat.dart';
import '/screen/connection.dart';
import '/screen/home.dart';
import '/screen/notification.dart';
import '/screen/your_network.dart';
import '/widgets/drawer_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _activeIndex = 0;

  final List<String> _title = [
    'Home',
    'Connection',
    'Messaging',
    'Your Network'
  ];

  final _advancedDrawerController = AdvancedDrawerController();
  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }

  //for appBar and Navigator bar hide
  //
  bool _isVisible = true;
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    _getData();
    controller = ScrollController();
    controller.addListener(() {
      setState(() {
        _isVisible =
            controller.position.userScrollDirection == ScrollDirection.forward;
      });
    });
  }

//for knowing who is login'
  String choice = '';

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      choice = prefs.getString('choice')!;
    });

    return choice;
  }

  //for message if not alumni

  _message() {
    var message = 'you can not post anything ';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        duration: Duration(seconds: 3),
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _unSelectedbottomNavigationBarColor = Theme.of(context).canvasColor;
    final _selectedbottomNavigationBarColor = Colors.grey;
    final List<Widget> _children = [
      HomeScreen(controller),
      ConnectionScreen(),
      ChatScreen(),
      YourNetworkScreen(),
    ];

    return AdvancedDrawer(
      drawer: DrawerApp(_advancedDrawerController),
      backdropColor: Colors.blueGrey,
      controller: _advancedDrawerController,
      child: Scaffold(
          appBar: _isVisible
              ? AppBar(
                  leading: IconButton(
                    onPressed: _handleMenuButtonPressed,
                    icon: ValueListenableBuilder<AdvancedDrawerValue>(
                      valueListenable: _advancedDrawerController,
                      builder: (context, value, child) {
                        return Icon(
                          value.visible ? Icons.clear : Icons.menu,
                        );
                      },

                      //see this after

                      // child: YourNetworkScreen(),
                    ),
                  ),
                  centerTitle: true,
                  title: Text(_title[_activeIndex],
                      style: TextStyle(color: Theme.of(context).canvasColor)),
                  backgroundColor: Theme.of(context).primaryColor,
                  iconTheme:
                      IconThemeData(color: Theme.of(context).canvasColor),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(NotificationPage.routeName);
                        },
                        icon: Icon(Icons.notifications_none_outlined))
                  ],
                )
              : PreferredSize(
                  child: Container(),
                  preferredSize: Size(0.0, 0.0),
                ),
          body: IndexedStack(
            children: _children,
            index: _activeIndex,
          ),
          floatingActionButton: Offstage(
            offstage: !_isVisible,
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: choice == 'Alumni'
                    ? () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return SharePost();
                        }));
                      }
                    : _message,
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                )),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Offstage(
            offstage: !_isVisible,
            child: BottomAppBar(
                color: Theme.of(context).primaryColor,
                shape: CircularNotchedRectangle(),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.home),
                          color: _activeIndex == 0
                              ? _selectedbottomNavigationBarColor
                              : _unSelectedbottomNavigationBarColor,
                          onPressed: () {
                            setState(() {
                              _activeIndex = 0;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.dns),
                          color: _activeIndex == 1
                              ? _selectedbottomNavigationBarColor
                              : _unSelectedbottomNavigationBarColor,
                          onPressed: () {
                            setState(() {
                              _activeIndex = 1;
                            });
                          }),
                      SizedBox(width: 20),
                      IconButton(
                          icon: Icon(Icons.chat),
                          color: _activeIndex == 2
                              ? _selectedbottomNavigationBarColor
                              : _unSelectedbottomNavigationBarColor,
                          onPressed: () {
                            setState(() {
                              _activeIndex = 2;
                            });
                          }),
                      IconButton(
                          icon: Icon(Icons.record_voice_over),
                          color: _activeIndex == 3
                              ? _selectedbottomNavigationBarColor
                              : _unSelectedbottomNavigationBarColor,
                          onPressed: () {
                            setState(() {
                              _activeIndex = 3;
                            });
                          })
                    ])),
          )),
    );
  }
}
