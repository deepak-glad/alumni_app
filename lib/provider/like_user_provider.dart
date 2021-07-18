// import 'package:flutter/cupertino.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test_appp/module/feed_get.dart';
// import 'package:test_appp/module/likeDislike_model.dart';

// class LikeUserProvider with ChangeNotifier {
//   int _likecount = 0;
//   List likedUser = [];

//   Future<void> feedApiData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var value = prefs.getString('token');
//     var url = Uri.parse('https://alumni-supervision.herokuapp.com/post/get');
//     http.Response reponse = await http.get(url, headers: {
//       HttpHeaders.authorizationHeader: value.toString(),
//     });
//     final jsonBody = reponse.body;
//     final jsonMap = jsonDecode(jsonBody);
//     var data = Feeds.fromJson(jsonMap);
//     _likecount = data.data.forEach((element) {
//       element.likeCount;
//     });
//   }

//   notifyListeners();
//   get likecount => _likecount;
// }
