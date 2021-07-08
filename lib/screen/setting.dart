import '/screen/notification.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = 'seeting-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text('Setting',
            style: TextStyle(color: Theme.of(context).primaryColor)),
        // backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationPage.routeName);
              },
              icon: Icon(Icons.notifications_none_outlined))
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person_pin_circle),
                title: Text('Account preferences'),
                subtitle: Text(
                    'The basics of your profile and experience on this alumni app'),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.lock),
                title: Text('Sign in & Security'),
                subtitle: Text(
                    'Option and controls for signing in and keeping your account safe'),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.remove_red_eye_outlined),
                title: Text('Visibility'),
                subtitle: Text(
                    'Control who sees your activity and information on this alumni app '),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.restore_page_outlined),
                title: Text('Advertising data'),
                subtitle: Text(
                    'Control how data uses your information to serve you ads'),
                onTap: () {},
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
