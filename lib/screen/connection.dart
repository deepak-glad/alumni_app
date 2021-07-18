import 'package:flutter/cupertino.dart';

import '/screen/friendsList.dart';
import '/screen/requestFriendList.dart';
import '/sub_screen/connection_suggestion.dart';
import 'package:flutter/material.dart';

class ConnectionScreen extends StatefulWidget {
  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen>
    with SingleTickerProviderStateMixin {
  final _Pages = <Widget>[ConnectionSuggestion(), ConnectionSuggestion()];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.blueGrey,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: 'Suggestion'),
                  Tab(text: 'Friends'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: _Pages),
            ),
          ],
        ),
      ),
    );
  }
}
