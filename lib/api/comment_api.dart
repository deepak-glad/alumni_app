import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_appp/module/comment_model.dart';
import 'package:test_appp/module/comment_model.dart';
import 'package:test_appp/module/comment_model.dart';

Future<void> commentData(String postId, String message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var body = {"comment": message};
  var url = Uri.parse(
      'https://alumni-supervision.herokuapp.com/post/comments/$postId');
  http.Response reponse =
      await http.patch(url, body: jsonEncode(body), headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  print('$jsonMap posting data');
}

Future<Comment> CommentGetData(String postId) async {
  var data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');

  var url = Uri.parse(
      'https://alumni-supervision.herokuapp.com/post/likes-Comment/$postId');
  http.Response reponse = await http.patch(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = Comment.fromJson(jsonMap);
  print("$jsonMap geting datta");
  return data;
}
