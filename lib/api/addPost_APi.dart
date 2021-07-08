import 'dart:convert';
import 'dart:io';
import 'package:test_appp/module/Image_upload.dart';
import 'package:test_appp/widgets/home_widgets.dart';
import '/screen/addNewFeed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class SharePost extends StatefulWidget {
  @override
  _SharePostState createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  var isLaoding = false;

  Future<void> _onsubmit(String title, String des, BuildContext cc,
      List photoArray, List videoData) async {
    var defaultmessage = 'added successfully';
    setState(() {
      isLaoding = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('token');
    if (photoArray.isNotEmpty) {
      var formData = FormData();
      for (var file in photoArray) {
        String fileName = file.path.split('/').last;

        formData.files.addAll([
          MapEntry("media",
              await MultipartFile.fromFile(file.path, filename: fileName)),
        ]);
      }
      Map<String, String> headers = {
        'Authorization': '$value',
        "Content-Type": "multipart/form-data",
      };
      var dio = Dio();
      var response = await dio.post(
          "https://alumni-supervision.herokuapp.com/uploadMedia",
          data: formData,
          options: Options(headers: headers));
      print(response.data);
      Map<String, dynamic> userMap = response.data;
      var user = ImageUpload.fromJson(userMap);
      // var urlValue;
      // user.data.forEach((element) {
      //   urlValue = element.location;
      // });
      // print(urlValue);
      var url = Uri.parse('https://alumni-supervision.herokuapp.com/post/add');
      var urlArray = [];
      for (var index in user.data) {
        var url = {
          // "title": title,
          // "discription": des,
          // "MediaUrl": [
          'url': index.location
          // ]
        };
        urlArray.add(url);
      }
      var data = {"title": title, "discription": des, "MediaUrl": urlArray};
      if (response.statusCode == 200 && user.status) {
        var responsePost =
            await http.post(url, body: jsonEncode(data), headers: {
          "Content-Type": "application/json",
          HttpHeaders.authorizationHeader: value.toString(),
        });
        var message = 'added successfully';
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(message),
            backgroundColor: Theme.of(cc).primaryColor,
          ),
        );
        print(responsePost.body);
        if (responsePost.statusCode == 200) {
          Navigator.of(cc).pop();
        }
        setState(() {
          isLaoding = false;
        });
      } else {
        var message =
            user.message != null ? user.message : 'somthing went wrong';
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(message),
            backgroundColor: Theme.of(cc).errorColor,
          ),
        );
        setState(() {
          isLaoding = false;
        });
      }
    } else {
      var url = Uri.parse('https://alumni-supervision.herokuapp.com/post/add');
      var data = {
        "title": title,
        "discription": des,
        // "MediaUrl": [
        //   {"url": user.data[0].location}
        // ]
      };
      var responsePost = await http.post(url, body: jsonEncode(data), headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: value.toString(),
      });
      var jsonBody = json.decode(responsePost.body);
      print(jsonBody);
      if (responsePost.statusCode == 200 && jsonBody['status']) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          elevation: 2,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 3),
          content: Text(defaultmessage),
          backgroundColor: Colors.blueGrey[300],
        ));
        Navigator.of(cc).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => HomePage(),
            ),
            (Route<dynamic> route) => false);
        setState(() {
          isLaoding = false;
        });
      } else {
        var message = 'somthing went wrong';
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(message),
            backgroundColor: Theme.of(cc).errorColor,
          ),
        );
        setState(() {
          isLaoding = false;
        });
      }
      setState(() {
        isLaoding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddNewFeed(isLaoding, _onsubmit);
  }
}
