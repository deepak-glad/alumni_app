import 'package:test_appp/screen/myfriends_profile_full.dart';

import '/api/registration_al.dart';
import '/module/home_data.dart';
import '/module/message_module.dart';
import '/screen/calender.dart';
import '/screen/jobs.dart';
import '/screen/notification.dart';
import '/screen/requestFriendList.dart';
import '/screen/setting.dart';
import '/widgets/home_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api/forget.dart';
import 'api/registration_student.dart';
import 'widgets/onetime.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => HomeDataProvider()),
        ChangeNotifierProvider.value(value: MessageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Alumini Supervision',
        theme: ThemeData(
          primaryColor: Colors.blueGrey,
          // ignore: deprecated_member_use
          accentColor: Colors.black,
          canvasColor: Colors.white,
          bottomAppBarColor: Color.fromRGBO(0, 136, 255, 1),
          // focusColor: Colors.blueAccent,
          // textTheme:
          //     TextTheme(headline1: TextStyle(color: Colors.white, fontSize: 25)),
        ),
        home: Splash(),
        routes: {
          HomePage.routeName: (ctx) => HomePage(),
          NotificationPage.routeName: (ctx) => NotificationPage(),
          // MessageScreen.routeName:(ctx)=>MessageScreen(),
          EventsScreen.routeName: (ctx) => EventsScreen(),
          RegistrationAlumini.routeName: (ctx) => RegistrationAlumini(),
          RegistrationStudent.routeName: (ctx) => RegistrationStudent(),
          ForgetPasswordApi.routename: (ctx) => ForgetPasswordApi(),
          JobsScreen.routeName: (ctx) => JobsScreen(),
          SettingScreen.routeName: (ctx) => SettingScreen(),
          RequestFriendList.routeName: (ctx) => RequestFriendList(),
          MyFriendsProfile.routename: (ctx) => MyFriendsProfile(),
        },
      ),
    );
  }
}
