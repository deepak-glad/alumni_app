import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();

  //image from camera
  var _pickedImage;
  void _pickImage() async {
    final pickImageFile = await _picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxHeight: 150,
    );
    setState(() {
      _pickedImage = File(pickImageFile!.path);
    });
  }

  ///for image from gallery
  var _pickfromGallery;
  void _pickFromGallery() async {
    final pickImageGallery = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 150,
    );
    setState(() {
      _pickfromGallery = File(pickImageGallery!.path);
    });
  }

  ///fro video from gallery
  late VideoPlayerController _controller;
  late File _video;
  final picker = ImagePicker();
  _pickvideoFromGallery() async {
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile!.path);
    _controller = VideoPlayerController.file(_video)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize();
  }

  ///picked date
  // DateTime date;
  // void _selectDate() async {
  //   final DateTime picked = await showDatePicker(
  //     context: context,
  //     initialDate: date == null ? widget.date : date,
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2050),
  //   );
  //   if (picked != null && picked != date)
  //     setState(() {
  //       date = picked;
  //     });
  // }

  //for sending data to api
  _onsubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print(_pickedImage);
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
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.amber,
          height: MediaQuery.of(context).size.height,
          // padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
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
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300)),
              Divider(),
              // SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          // offset:
                        ),
                      ]),
                  height: MediaQuery.of(context).size.height * 2 / 3 + 50,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        controller: eventName,
                        key: ValueKey('eventName'),
                        validator: (value) {
                          if (value!.isEmpty) return 'Please enter event name';
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Event name',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: description,
                        key: ValueKey('des'),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please describe about event';
                          return null;
                        },
                        maxLines: 7,
                        decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            )),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: venue,
                        key: ValueKey('venue'),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter venue address';
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Venue',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: GestureDetector(
                          // onTap: _selectDate,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Choosen date',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300)),
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
                              builder: (cxt) => Container(
                                    height: 75,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton.icon(
                                            label: Text(
                                              'Camera',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: _pickImage,
                                            icon: Icon(Icons.camera, size: 40)),
                                        TextButton.icon(
                                            label: Text(
                                              'Gallery',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: _pickFromGallery,
                                            icon: Icon(
                                              Icons.image,
                                              size: 40,
                                            )),
                                        TextButton.icon(
                                            label: Text(
                                              'Video',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: _pickvideoFromGallery,
                                            icon: Icon(
                                              Icons.video_library_sharp,
                                              size: 40,
                                            ))
                                      ],
                                    ),
                                  ));
                        },
                        child: Container(
                          height: 100,
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
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
