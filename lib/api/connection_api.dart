import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test_appp/module/pendin_model.dart';

import '/module/suggestion.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Welcome> connectionSuggestion() async {
  var data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var url =
      Uri.parse('https://alumni-supervision.herokuapp.com/connect/suggest');
  http.Response reponse = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = Welcome.fromJson(jsonMap);
  return data;
}

Future<Welcome> myFriendsList() async {
  var data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var url =
      Uri.parse('https://alumni-supervision.herokuapp.com/connect/myfriend');
  http.Response reponse = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = Welcome.fromJson(jsonMap);
  print(jsonMap);
  return data;
}

Future<Pending> mypendingREquest() async {
  var data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var url =
      Uri.parse('https://alumni-supervision.herokuapp.com/connect/pending');
  http.Response reponse = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = Pending.fromJson(jsonMap);
  print(jsonMap);
  return data;
}

Future<void> addFriend(String requestedID, BuildContext cc) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var data = {"requestValue": true};
  var url = Uri.parse(
      'https://alumni-supervision.herokuapp.com/connect/accept/$requestedID');
  http.Response response =
      await http.patch(url, body: jsonEncode(data), headers: {
    HttpHeaders.authorizationHeader: value.toString(),
    "Accept": "application/json",
    'Content-Type': 'application/json; charset=UTF-8',
  });
  var jsonResponse = json.decode(response.body);
  print(jsonResponse);
  // print(jsonResponse['data']['targetUser']);
  if (response.statusCode == 200 && jsonResponse['status']) {
    var ms = 'friend requested accepted';
    ScaffoldMessenger.of(cc).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        content: Text(ms),
        backgroundColor: Theme.of(cc).primaryColor,
      ),
    );
  } else {
    var message = jsonResponse["message"];
    ScaffoldMessenger.of(cc).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        content: Text(message),
        backgroundColor: Theme.of(cc).errorColor,
      ),
    );
  }
}
