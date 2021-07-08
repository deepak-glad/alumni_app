import 'dart:async';
import '/screen/login.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '/widgets/home_widgets.dart';

class Authe extends StatefulWidget {
  @override
  _AutheState createState() => _AutheState();
}

class _AutheState extends State<Authe> {
  //internet
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  bool isLoading = false;
  Future signInMethod(String email, String pass, bool rem, String choice,
      BuildContext cc) async {
    print(choice);
    setState(() {
      isLoading = true;
    });
    if (_connectionStatus == ConnectivityResult.wifi.toString() ||
        _connectionStatus == ConnectivityResult.mobile.toString()) {
      var data = {"email": email, "password": pass};
      var url = Uri.parse(choice == 'student'
          ? 'https://alumni-supervision.herokuapp.com/user/login'
          : 'https://alumni-supervision.herokuapp.com/alumni/login');

//for local host testing
      // var url = (choice == 'student'
      //         ? 'http://localhost:5000/user/login'
      //         : 'http://localhost:5000/alumni/login');

      //for dio package
      // var dio = Dio();
      //   var response = await dio.post(url, data: data);
      //   print(response.data.toString());
      //   if (response.statusCode == 200) {
      //     return Navigator.of(cc).pushAndRemoveUntil(
      //         MaterialPageRoute(
      //           builder: (BuildContext context) => HomePage(),
      //         ),
      //         (Route<dynamic> route) => false);
      //   }
      http.Response response =
          await http.post(url, body: jsonEncode(data), headers: {
        "Accept": "application/json",
        'Content-Type': 'application/json; charset=UTF-8',
      });
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200 && jsonResponse['status']) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", rem);
        final key = 'token';
        final value = jsonResponse['data']['token'];
        print(value);
        prefs.setString(key, value);
        final key1 = 'choice';
        final value1 = choice;
        prefs.setString(key1, value1);
        final key2 = 'name';
        final value2 = '${jsonResponse['data']['firstName']}'
            ' ${jsonResponse['data']['lastName']}';
        prefs.setString(key2, value2);
        return Navigator.of(cc).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ),
            (Route<dynamic> route) => false);
      } else if (jsonResponse['status'] == false) {
        var d = jsonResponse['msg'];
        ScaffoldMessenger.of(cc).showSnackBar(SnackBar(
          duration: Duration(seconds: 5),
          content: Text(d),
          backgroundColor: Theme.of(cc).errorColor,
        ));
        setState(() {
          isLoading = false;
        });
      } else {
        var message = 'An error occurred,please check your credential';
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(message),
            backgroundColor: Theme.of(cc).errorColor,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } else {
      var message =
          'please check your network or try again later after sometime latter';
      ScaffoldMessenger.of(cc).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(cc).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(_connectionStatus == ConnectivityResult.wifi.toString());
    return Scaffold(
      body: LoginPage(signInMethod, isLoading),
    );
  }
}
