import 'dart:convert';
import 'dart:io';
import '/screen/event_add.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'eventApi.dart';

class AddEvent extends StatefulWidget {
  final DateTime date;
  AddEvent(this.date);
  // static const routeName = 'add-Event';
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var isLaoding = false;
  _onsubmit(String title, String des, String venue, String date,
      BuildContext cc) async {
    setState(() {
      isLaoding = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('token');
    var data = {
      "title": title,
      "description": des,
      "venue": venue,
      "date": date,
      // "MediaUrl": media,
    };
    var url = Uri.parse('https://alumni-supervision.herokuapp.com/event/add');
    http.Response response =
        await http.post(url, body: jsonEncode(data), headers: {
      "Content-Type": "application/json",
      HttpHeaders.authorizationHeader: value.toString(),
    });
    var jsonResponse = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200 && jsonResponse['status']) {
      Navigator.of(context).pop();
      var message = 'successfully addded event please refresh it to see';
      ScaffoldMessenger.of(cc).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(cc).primaryColor,
        ),
      );
      setState(() {
        isLaoding = false;
      });
    } else {
      var message = 'somthing went wrong';
      ScaffoldMessenger.of(cc).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
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

  @override
  Widget build(BuildContext context) {
    return EventAdd(isLaoding, widget.date, _onsubmit);
  }
}
