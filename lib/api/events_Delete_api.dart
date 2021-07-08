import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

onDelete(String id, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var url =
      Uri.parse('https://alumni-supervision.herokuapp.com/event/delete/$id');
  http.Response response = await http.patch(url, headers: {
    "Content-Type": "application/json",
    HttpHeaders.authorizationHeader: value.toString(),
  });
  print(response.body);
  var data = json.decode(response.body);
  print(data['status']);
  if (response.statusCode == 200 && data['status'])
    return Navigator.of(context).pop();
}
