import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

onpress(String id, BuildContext cc) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var url = Uri.parse(
      'https://alumni-supervision.herokuapp.com/connect/addFriend/$id');
  http.Response response = await http.post(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  var jsonResponse = json.decode(response.body);
  print(jsonResponse);
  // print(jsonResponse['data']['targetUser']);
  if (response.statusCode == 200 && jsonResponse['status']) {
    var ms = jsonResponse["data"];
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
