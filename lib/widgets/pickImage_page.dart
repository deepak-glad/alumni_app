import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class PickImagePage extends StatefulWidget {
  final Function(File pickImaged) photo;
  PickImagePage(this.photo);

  @override
  _PickImagePageState createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  final ImagePicker _picker = ImagePicker();

  var _pickedImage;

  void _pickImage() async {
    final pickImageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 900,
      maxHeight: 900,
      imageQuality: 100,
    );
    setState(() {
      _pickedImage = File(pickImageFile!.path);
      if (_pickedImage != null) widget.photo(_pickedImage);
      // if (_pickfromGallery != null) widget.photo(_pickfromGallery);
    });
    Navigator.of(context).pop();
  }

  ///for image from gallery
  var _pickfromGallery;

  void _pickFromGallery() async {
    final pickImageGallery = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 900,
      maxHeight: 900,
      imageQuality: 100,
    );
    setState(() {
      _pickfromGallery = File(pickImageGallery!.path);
      if (_pickfromGallery != null) widget.photo(_pickfromGallery);
    });

    Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    // print(_pickfromGallery);
    return Container(
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton.icon(
              label: Text(
                'Camera',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: _pickImage,
              icon: Icon(Icons.camera, size: 40)),
          TextButton.icon(
              label: Text(
                'Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: _pickFromGallery,
              icon: Icon(
                Icons.image,
                size: 40,
              )),
          TextButton.icon(
              label: Text(
                'Video',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: _pickvideoFromGallery,
              icon: Icon(
                Icons.video_library_sharp,
                size: 40,
              ))
        ],
      ),
    );
  }
}
