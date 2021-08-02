import '/api/authentication.dart';
import '/screen/calender.dart';
import '/screen/jobs.dart';
import '/screen/setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerApp extends StatelessWidget {
  final value;
  DrawerApp(this.value);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 40.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/menu.png',
                ),
              ),
              ListTile(
                title: Text(
                  'Events',
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  value.hideDrawer();
                  Navigator.of(context).pushNamed(EventsScreen.routeName);
                },
                leading: Icon(
                  Icons.event_available_outlined,
                ),
              ),
              ListTile(
                title: Text(
                  'Jobs',
                ),
                onTap: () {
                  value.hideDrawer();

                  Navigator.of(context).pushNamed(JobsScreen.routeName);
                },
                leading: Icon(
                  Icons.work_outline_outlined,
                ),
              ),
              // ListTile(
              //   title: Text(
              //     'Gallery',
              //   ),
              //   onTap: () {
              //     // Navigator.of(context).pop();
              //     // Navigator.of(context).pushNamed(Category.routeName);
              //   },
              //   onLongPress: () {
              //     Navigator.of(context).pop();
              //   },
              //   leading: Icon(
              //     Icons.image_outlined,
              //   ),
              // ),
              // Divider(color: Theme.of(context).accentColor),
              ListTile(
                title: Text(
                  'setting',
                ),
                onTap: () {
                  value.hideDrawer();
                  Navigator.of(context).pushNamed(SettingScreen.routeName);
                },
                onLongPress: () {
                  Navigator.of(context).pop();
                },
                leading: Icon(
                  Icons.settings_outlined,
                ),
              ),
              // ListTile(
              //   title: Text(
              //     'App FeedBack',
              //   ),
              //   onTap: () {
              //     // Navigator.of(context).pop();
              //     // Navigator.of(context).pushNamed(Category.routeName);
              //   },
              //   onLongPress: () {
              //     Navigator.of(context).pop();
              //   },
              //   leading: Icon(
              //     Icons.emoji_emotions_outlined,
              //   ),
              // ),
              ListTile(
                title: Text(
                  'Invite Friends',
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(Category.routeName);
                },
                leading: Icon(
                  Icons.insert_invitation_outlined,
                ),
              ),
              // ListTile(
              //   title: Text(
              //     'Contact Us',
              //   ),
              //   onTap: () {
              //     // Navigator.of(context).pop();
              //     // Navigator.of(context).pushNamed(Category.routeName);
              //   },
              //   onLongPress: () {
              //     Navigator.of(context).pop();
              //   },
              //   leading: Icon(
              //     Icons.contact_page_outlined,
              //   ),
              // ),
              ListTile(
                title: Text(
                  'About Us',
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(Category.routeName);
                },
                leading: Icon(
                  Icons.golf_course,
                ),
              ),
              ListTile(
                title: Text(
                  'Rate Us',
                ),
                onTap: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(Category.routeName);
                },
                leading: Icon(
                  Icons.rate_review_outlined,
                ),
              ),
              ListTile(
                title: Text(
                  'Logout',
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  // prefs?.clear();
                  prefs.remove('isLoggedIn');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext ctx) => Authe()));
                },
                leading: Icon(
                  Icons.logout,
                ),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 11.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
