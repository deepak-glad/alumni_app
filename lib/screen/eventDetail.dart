import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EventDetail extends StatefulWidget {
  final String title;
  final String des;
  final String venue;
  final List photo;
  final DateTime date;
  final String id;
  const EventDetail(
      this.title, this.des, this.photo, this.venue, this.date, this.id);

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  var isloading = false;
  var message = 'You can not delete this event';
  var succ = 'Deleted succesfully please refresh to see result';

  onDelete(String id, BuildContext context) async {
    setState(() {
      isloading = true;
    });
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
    if (response.statusCode == 200 && data['status']) {
      // return Navigator.of(context).pop();
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
          content: Text(succ),
          backgroundColor: Colors.green,
        ),
      );
      setState(() {
        isloading = false;
      });
    } else
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(photo);
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        centerTitle: true,
        actions: [
          isloading
              ? Center(child: CircularProgressIndicator())
              : IconButton(
                  onPressed: () => onDelete(widget.id, context),
                  icon: Icon(Icons.delete))
        ],
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(20),
                  //     topRight: Radius.circular(20)),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      // color: Colors.black54,
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                      // offset:
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/events.jpg'),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w400),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child: Text(
                      DateFormat.MMMEd().format(widget.date),
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                // height: MediaQuery.of(context).size.height / 3,
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(20),
                    //     topRight: Radius.circular(20)),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.black54,
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                        // offset:
                      ),
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Text(
                          'Venue: ${widget.venue}',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 8),
                      child: Text(
                        widget.des,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
