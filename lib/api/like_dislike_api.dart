import 'package:test_appp/module/likeDislike_model.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<LikeDislikeModel> likeDisLike(String postId) async {
  var data;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var value = prefs.getString('token');
  var url =
      Uri.parse('https://alumni-supervision.herokuapp.com/post/like/$postId');
  http.Response reponse = await http.patch(url, headers: {
    HttpHeaders.authorizationHeader: value.toString(),
  });
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = LikeDislikeModel.fromJson(jsonMap);
  print(jsonMap);
  return data;
}
