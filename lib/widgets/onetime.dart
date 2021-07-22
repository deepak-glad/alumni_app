import '/api/authentication.dart';
import '/screen/internet_check.dart';
import '/skip_page/slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'home_widgets.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    bool status = prefs.getBool('isLoggedIn') ?? false;

    //for internet check if it connected or not
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => InternetCheck()));
    } else if (_seen) {
      if (!status)
        Timer(
            Duration(milliseconds: 2500),
            () => Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => Authe())));
      else
        Timer(
            Duration(milliseconds: 2500),
            () => Navigator.of(context).pushReplacement(
                new MaterialPageRoute(builder: (context) => HomePage())));
    } else {
      await prefs.setBool('seen', true);
      Timer(
          Duration(milliseconds: 2500),
          () => Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => SliderPage())));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/splash_logo.gif'),
      ),
    );
  }
}
