import 'dart:convert';
import 'dart:io';
import '/module/friendsList_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Welcome> friendsList() async {
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
  return data;
}
