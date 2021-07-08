import 'package:flutter/material.dart';
import 'notification.dart';

class JobsScreen extends StatelessWidget {
  static const routeName = 'jobs-Screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search Jobs',
            style: TextStyle(color: Theme.of(context).canvasColor)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).canvasColor),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationPage.routeName);
              },
              icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.insert_emoticon_outlined),
                title: Text('Company name'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('sort description'),
                    Text('location'),
                    Text('time'),
                    Divider(),
                  ],
                ),
                trailing: Icon(Icons.save),
              ),
              ListTile(
                leading: Icon(Icons.insert_emoticon_outlined),
                title: Text('Company name'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('sort description'),
                    Text('location'),
                    Text('time'),
                    Divider(),
                  ],
                ),
                trailing: Icon(Icons.save),
              ),
              ListTile(
                leading: Icon(Icons.insert_emoticon_outlined),
                title: Text('Company name'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('sort description'),
                    Text('location'),
                    Text('time'),
                    Divider(),
                  ],
                ),
                trailing: Icon(Icons.save),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
