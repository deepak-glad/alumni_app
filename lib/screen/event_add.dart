import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_appp/widgets/pickImage_page.dart';
import 'package:video_player/video_player.dart';
import 'package:intl/intl.dart';

class EventAdd extends StatefulWidget {
  final bool isLoading;
  final DateTime date;
  final void Function(String title, String description, String venue,
      String date, BuildContext ctx) submitBt;
  EventAdd(this.isLoading, this.date, this.submitBt);

  @override
  _EventAddState createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {
  TextEditingController eventName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController venue = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var _pickImageArray = [];
  _pickImage(File pickImage) {
    setState(() {
      _pickImageArray.add(pickImage);
    });
  }

  //for sending data to api
  _onsubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      if (eventName.text.isNotEmpty &&
          description.text.isNotEmpty &&
          venue.text.isNotEmpty) {
        // if (date != null) {
        //   widget.submitBt(eventName.text, description.text, venue.text, date,
        //       _pickedImage, context);
        // } else
        // if(_pickedImage !=null)
        // widget.submitBt(eventName.text, description.text, venue.text,
        //     widget.date, _pickedImage, context);
        //     else
        widget.submitBt(eventName.text, description.text, venue.text,
            widget.date.toIso8601String(), context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // color: Colors.yellow,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          elevation: 2,
                          alignment: Alignment.center,
                          primary: Colors.red[100],
                          onPrimary: Colors.white,
                        ),
                        child: Icon(
                          Icons.logout_sharp,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      widget.isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                elevation: 2,
                                alignment: Alignment.center,
                                primary: Colors.green[100],
                                onPrimary: Colors.white,
                              ),
                              child: Icon(
                                Icons.check,
                                color: eventName.text.isNotEmpty
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              onPressed:
                                  eventName.text.isNotEmpty ? _onsubmit : null,
                            )
                    ],
                  ),
                ),
                Text('Event',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
                Divider(),

                TextFormField(
                  controller: eventName,
                  key: ValueKey('eventName'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter event name';
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Event name',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: description,
                  key: ValueKey('des'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please describe about event';
                    return null;
                  },
                  maxLines: 7,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: venue,
                  key: ValueKey('venue'),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter venue address';
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Venue',
                      hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.teal[50],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: .5,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: GestureDetector(
                    // onTap: _selectDate,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Choosen date',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300)),
                        Text(
                            // date != null
                            //     ? '${DateFormat.yMMMd().format(date)} >'

                            //     :
                            '${DateFormat.yMMMd().format(widget.date)} ',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (cxt) => PickImagePage(_pickImage));
                  },
                  child: Container(
                    height: 150,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: .5,
                                      spreadRadius: 0.0)
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Icon(Icons.add, size: 40),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: _pickImageArray.length,
                              itemBuilder: (context, index) {
                                print(_pickImageArray[index]);
                                return Stack(children: [
                                  Container(
                                    margin: const EdgeInsets.all(8),
                                    height: 150,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black,
                                              blurRadius: .5,
                                              spreadRadius: 0.0)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Image.file(
                                      _pickImageArray[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    key: Key(_pickImageArray[index].toString()),
                                    padding: const EdgeInsets.all(2),
                                    child: GestureDetector(
                                        child: Container(
                                          // height: 35,
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    spreadRadius: 1,
                                                    color: Colors.black12,
                                                    offset:
                                                        Offset.fromDirection(
                                                            0.9, 2.5),
                                                    blurRadius: 2.0)
                                              ],
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Icon(Icons.close, size: 15),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            _pickImageArray.removeAt(index);
                                          });
                                        }),
                                  )
                                ]);
                              })
                        ]),
                  ),
                ),
                // ],
                // ),
                // ),
                // )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
