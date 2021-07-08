import 'dart:convert';
import 'package:test_appp/screen/eventDetail.dart';

import '/api/add_Event_API.dart';
import '/api/eventApi.dart';
import '/module/eventModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class EventsScreen extends StatefulWidget {
  static const routeName = 'events-screen';

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  var array = [];
  var _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  late Map<DateTime, List<dynamic>> _events;

  var name;
  _profileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  late Future<Welcome> _future;
  @override
  void initState() {
    _profileData();
    eventDate();
    _future = eventApi();
    _selectedDay = _focusedDay;
    super.initState();
  }

  Future<void> eventDate() async {
    _events = {};
    var url = Uri.parse('https://alumni-supervision.herokuapp.com/event/get');
    http.Response reponse = await http.get(url);
    final jsonBody = reponse.body;
    final jsonMap = jsonDecode(jsonBody);
    var da = Welcome.fromJson(jsonMap);
    // date = jsonMap.map((item) => Welcome.fromJson(jsonMap)).toList();
    da.data.forEach((element) {
      // print(element.date);
      if (element.date != null) {
        // arraydate.add(element.date);
        DateTime formattedDate = DateTime.parse(element.date.toString());
        _getEventsForDay(formattedDate);
        if (_events.containsKey(formattedDate)) {
          _events[formattedDate]!.add(element.date.toString());
        } else {
          _events[formattedDate] = [element.date.toString()];
        }
      }
    });
    // return _events;
    setState(() {});
  }

  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    array = [];

    setState(() {
      _future = eventApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('College Events',
            style: TextStyle(color: Theme.of(context).canvasColor)),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).canvasColor),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(NotificationPage.routeName);
              },
              icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onPull,
        child: ListView(shrinkWrap: true, children: [
          Container(
              child: Column(
            children: [
              ListTile(
                title: Text('Hello,$name',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w400)),
                subtitle: Text("Lets explore what's happening in college",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                trailing: CircleAvatar(),
              ),
              TableCalendar(
                locale: 'en_US',
                calendarBuilders: CalendarBuilders(
                  dowBuilder: (context, day) {
                    if (day.weekday == DateTime.sunday ||
                        day.weekday == DateTime.saturday) {
                      final text = DateFormat.E().format(day);

                      return Center(
                        child: Text(
                          text,
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }
                  },
                ),
                daysOfWeekVisible: true,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      array = [];

                      // _rangeStart = null; // Important to clean those
                      // _rangeEnd = null;
                      // _rangeSelectionMode = RangeSelectionMode.toggledOff;
                    });

                    // _selectedEvents.value = _getEventsForDay(selectedDay);
                  }
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                    array = [];
                  });
                },
                eventLoader: _getEventsForDay,
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                  // array = [];
                },
                pageJumpingEnabled: true,
                firstDay: DateTime(2000),
                lastDay: DateTime(2090),
                focusedDay: _focusedDay,
              ),
              //  ..._list
              //                 .map((event) => Text(event[_focusedDay].toString()))
              //                 .toList(),
              Divider(color: Colors.black54),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Things to do',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              FutureBuilder<Welcome>(
                  future: _future,
                  builder: (context, snashot) {
                    if (snashot.hasData) {
                      for (var e in snashot.data!.data) {
                        if (e.date == _focusedDay) {
                          array.add(e);
                        }
                      }
                      if (array.isNotEmpty) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: array.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(),
                                title: Text(array[index].title),
                                subtitle: Text(array[index].description),
                                trailing: Text(array[index].venue),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EventDetail(
                                              array[index].title,
                                              array[index].description,
                                              array[index].mediaUrl,
                                              array[index].venue,
                                              array[index].date,
                                              array[index].id),
                                    ),
                                  );
                                },
                              );
                            });
                      } else
                        return Container(
                            margin: const EdgeInsets.all(10),
                            child: Text(
                              'No Event Found',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ));
                    }
                    return Center(child: CircularProgressIndicator());
                  }),
            ],
          )),
        ]),
      ),

      floatingActionButton: Ink(
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape: CircleBorder(),
        ),
        child: IconButton(
            color: Theme.of(context).canvasColor,
            onPressed: _focusedDay.compareTo(DateTime.now()) >= 0
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AddEvent(_focusedDay),
                    ));
                  }
                : null,
            icon: Icon(Icons.add)),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
