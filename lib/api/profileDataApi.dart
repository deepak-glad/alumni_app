import 'dart:convert';
import 'dart:io';
import '/module/connection.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Welcome> profileDataApi() async {
  var data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var choice = prefs.getString('choice');
  // print(value);

  var url = Uri.parse(choice == 'student'
      ? 'https://alumni-supervision.herokuapp.com/user/profile'
      : 'https://alumni-supervision.herokuapp.com/alumni/profile');
  http.Response reponse = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = Welcome.fromJson(jsonMap);
  return data;
}
