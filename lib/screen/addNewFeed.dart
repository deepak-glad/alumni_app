import 'dart:io';
import '/widgets/anyonetoeveryone.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class AddNewFeed extends StatefulWidget {
  final bool isLoading;
  final Function(String title, String des, BuildContext cc, List photoData)
      submit;
  AddNewFeed(this.isLoading, this.submit);
  @override
  _AddNewFeedState createState() => _AddNewFeedState();
}

class _AddNewFeedState extends State<AddNewFeed> {
  // final message = new TextEditingController();
  // late TextEditingController message;
  // ignore: unused_field
  String _message = '';
  var name;
  var whocanvalue = 'anyone';
  var _pickedImage;
  var _pickfromGallery;
  var photoData = [];

  final ImagePicker _picker = ImagePicker();
  void _pickImage() async {
    final pickImageFile = await _picker.getImage(
      source: ImageSource.camera,
      maxWidth: 900,
      maxHeight: 900,
      imageQuality: 95,
      // rotate: 90,
    );
    print(pickImageFile!.path.length);
    setState(() {
      _pickedImage = File(pickImageFile.path);
      photoData.add(_pickedImage);
      // testCompressFile(_pickedImage);
    });
  }

  // Future<Uint8List> testCompressFile(File file) async {
  //   var result = await FlutterImageCompress.compressWithFile(
  //     file.absolute.path,
  //     minWidth: 2300,
  //     minHeight: 1500,
  //     quality: 94,
  //     rotate: 90,
  //   );
  //   print("kkkk ${file.lengthSync()}");
  //   print('dk ${result!.length}');
  //   print(result.lengthInBytes);
  //   return result;
  // }

  void _pickFromGallery() async {
    final pickImageGallery = await _picker.getImage(
      source: ImageSource.gallery,
      maxWidth: 900,
      maxHeight: 900,
      imageQuality: 95,
    );
    setState(() {
      _pickfromGallery = File(pickImageGallery!.path);
      photoData.add(_pickfromGallery);
    });
  }

  late VideoPlayerController _controller;

  var _video;
  final picker = ImagePicker();
  _pickvideoFromGallery() async {
    PickedFile? pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile!.path);
    _controller = VideoPlayerController.file(_video)
      ..addListener(() => setState(() {
            photoData.add(_video);
          }))
      ..setLooping(true)
      ..initialize();
  }

  Widget _buildVideoPlayerUI() {
    return Column(children: [
      Stack(alignment: AlignmentDirectional.topEnd, children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            if (_controller != null)
              FloatingActionButton(
                onPressed: () => _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play(),
                child: Icon(_controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow),
              ),
          ],
        ),
        // if (_controller != null)
        //   IconButton(
        //     onPressed: () {
        //       _controller.dispose();
        //     },
        //     icon: Icon(Icons.close),
        //   )
      ]),
      Text('${_controller.value.position}/${_controller.value.duration}'),
      VideoProgressIndicator(_controller, allowScrubbing: true),
    ]);
  }

  _whocansee(int value) {
    setState(() {
      if (value == 0)
        whocanvalue = 'anyone';
      else if (value == 1) {
        whocanvalue = 'connection Only';
      }
    });
  }

  _trySaving() {
    widget.submit(whocanvalue, _message, context, photoData);
  }

  @override
  void initState() {
    _data();
    super.initState();
  }

  _data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
    if (name == null) {
      return;
    }
    return name;
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return !widget.isLoading
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'Share Post',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Theme.of(context).primaryColor),
              actions: [
                TextButton(onPressed: _trySaving, child: Text('Post')),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).canvasColor,
            ),
            body: SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height * 2,
                padding: EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              'assets/profile1.jpg',
                            )),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                name == null ? 'name' : name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (ctx) =>
                                          AnyoneToEveryOne(_whocansee));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  width: 160,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(whocanvalue == 'connection Only'
                                          ? Icons.lock
                                          : Icons.group),
                                      Text(
                                        whocanvalue == 'connection Only'
                                            ? 'Connection Only'
                                            : 'Anyone',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [BoxShadow(blurRadius: 2.0)],
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //for textfield
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: Theme(
                        data: ThemeData(primaryColor: Colors.white),
                        child: TextField(
                          autocorrect: true,
                          onChanged: (value) {
                            setState(() {
                              _message = value;
                            });
                          },
                          // controller: message,
                          maxLines: 3,
                          enableSuggestions: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'What do you want to talk about ?'),
                        ),
                      ),
                    ),
                    if (photoData.length == 1)
                      Stack(textDirection: TextDirection.rtl, children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          // color: Colors.amber,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Image.file(
                            photoData[0],
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          key: Key(photoData[0].toString()),
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                              icon: Icon(Icons.close, size: 32),
                              onPressed: () {
                                setState(() {
                                  photoData.removeAt(0);
                                });
                              }),
                        )
                      ]),

                    if (photoData.length > 1)
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: photoData.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  //  maxCrossAxisExtent: 200,
                                  childAspectRatio: 4 / 5,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 5,
                                  crossAxisCount:
                                      (orientation == Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemBuilder: (context, index) {
                            print(photoData[index]);
                            return Stack(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    // color: Colors.amber,
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Image.file(
                                      photoData[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    key: Key(photoData[index].toString()),
                                    padding: const EdgeInsets.all(8),
                                    child: IconButton(
                                        icon: Icon(Icons.close, size: 32),
                                        onPressed: () {
                                          setState(() {
                                            photoData.removeAt(index);
                                          });
                                        }),
                                  )
                                  // Dismissible(
                                  //     key: Key(photoData[index].toString()),
                                  //     onDismissed: (direction) {
                                  //       setState(() {
                                  //         photoData.removeAt(index);
                                  //       });
                                  //     },
                                  //     child: Icon(Icons.close, size: 32)),
                                ]);
                          }),
                    // photoData.length == 1
                    // ? Stack(textDirection: TextDirection.rtl, children: [
                    //     Container(
                    //       padding: const EdgeInsets.all(8),
                    //       // color: Colors.amber,
                    //       width: MediaQuery.of(context).size.width,
                    //       height: MediaQuery.of(context).size.height / 2,
                    //       child: Image.file(
                    //         _pickedImage != null
                    //             ? _pickedImage
                    //             : _pickfromGallery != null
                    //                 ? _pickfromGallery
                    //                 : _video,
                    //         fit: BoxFit.cover,
                    //       ),
                    //     ),
                    //     Container(
                    //         padding: const EdgeInsets.all(8),
                    //         child: Icon(Icons.close, size: 32)),
                    //   ])
                    //     : Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //         children: [
                    //           // Container(
                    //           //   child: _pickedImage != null
                    //           //       ? Image.file(_pickedImage)
                    //           //       : null,
                    //           // ),
                    //           if (_pickedImage != null)
                    //             Stack(
                    //                 textDirection: TextDirection.rtl,
                    //                 children: [
                    //                   Container(
                    //                       padding: const EdgeInsets.all(8),
                    //                       color: Colors.amber,
                    //                       width: MediaQuery.of(context)
                    //                               .size
                    //                               .width -
                    //                           50 * (photoData.length + 1),
                    //                       height: MediaQuery.of(context)
                    //                               .size
                    //                               .height /
                    //                           2,
                    //                       child: Image.file(
                    //                         _pickedImage,
                    //                         fit: BoxFit.cover,
                    //                       )),
                    //                   Container(
                    //                       padding: const EdgeInsets.all(8),
                    //                       child: Icon(Icons.close, size: 32)),
                    //                 ]),
                    //           if (_pickfromGallery != null)
                    //             Stack(
                    //                 textDirection: TextDirection.rtl,
                    //                 children: [
                    //                   Container(
                    //                     padding: const EdgeInsets.all(8),
                    //                     // color: Colors.amber,
                    //                     width:
                    //                         MediaQuery.of(context).size.width -
                    //                             50 * (photoData.length + 1),
                    //                     height:
                    //                         MediaQuery.of(context).size.height /
                    //                             2,
                    //                     child: _pickfromGallery != null
                    //                         ? Image.file(
                    //                             _pickfromGallery,
                    //                             fit: BoxFit.cover,
                    //                           )
                    //                         : null,
                    //                   ),
                    //                   Container(
                    //                       padding: const EdgeInsets.all(8),
                    //                       child: Icon(Icons.close, size: 32)),
                    //                 ]),
                    // Container(
                    //   // width: MediaQuery.of(context).size.width,
                    //   child: _pickedImage != null
                    //       ? Image.file(_pickedImage)
                    //       : null,
                    // ),
                    // Container(
                    //   child: _pickfromGallery != null
                    //       ? Image.file(_pickfromGallery)
                    //       : null,
                    // ),
                    // Container(
                    //   child: _pickfromGallery != null
                    //       ? Image.file(_pickfromGallery)
                    //       : null,
                    // ),
                    // ],
                    // ),
                    if (_video != null)
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _controller.value.isInitialized
                            ? _buildVideoPlayerUI()
                            : const LinearProgressIndicator(),
                      )
                    else
                      Container(),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: _pickImage,
                  ),
                  IconButton(
                      onPressed: _pickvideoFromGallery,
                      icon: Icon(Icons.video_label)),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: _pickFromGallery,
                  ),
                  // IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                  SizedBox(width: 70),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.chat, color: Colors.black),
                    label: Text(
                      'Anyone',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
