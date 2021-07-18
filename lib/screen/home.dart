import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_appp/api/feed_get_api.dart';
import 'package:test_appp/api/like_dislike_api.dart';
import 'package:test_appp/module/feed_get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/sub_screen/comment.dart';
import '/sub_screen/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final controller;
  HomeScreen(this.controller);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Feeds> _future;
  CarouselController buttonCarouselController = CarouselController();
  var _current = 0;
  bool _descmore = false;
  var _likeuser = [];
  late List<Datum> _sortedArray = <Datum>[];
  @override
  void initState() {
    setState(() {
      _future = loginUserId();
      _future.then((value) {
        var date = DateTime.now();
        var sorted = value.data;
        sorted.sort((a, b) => date.compareTo(b.createdAt));
        _sortedArray = sorted;
      });
    });

    super.initState();
  }

  var dd;
  var value;
  Future<Feeds> loginUserId() async {
    var apiData;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString('token');
    var url = Uri.parse('https://alumni-supervision.herokuapp.com/post/get');
    http.Response reponse = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: value.toString(),
    });
    final jsonBody = reponse.body;
    final jsonMap = jsonDecode(jsonBody);
    var data = Feeds.fromJson(jsonMap);
    apiData = Feeds.fromJson(jsonMap);
    setState(() {
      value = prefs.getString('id');
      data.data.forEach((element) {
        element.likesUser.map((e) => e.alumni.id).contains(value)
            ? _likeuser.add(element.id)
            : null;
      });
    });
    return apiData;
  }

  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _future = loginUserId();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Feeds>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data.length == 0) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    'assets/nothing.png',
                    fit: BoxFit.cover,
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: _onPull,
                child: ListView.builder(
                    controller: widget.controller,
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      var apiData = _sortedArray[index];
                      // var date = DateTime.now();
                      // var sorted = snapshot.data!.data;
                      // sorted.sort((a, b) => date.compareTo(b.createdAt));
                      // var apiData = sorted[index];
                      return Column(children: [
                        if (index == 0)
                          GestureDetector(
                            onTap: () {
                              showSearch(
                                  context: context, delegate: DataSearch());
                            },
                            child: Container(
                              margin: const EdgeInsets.all(15),
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  shape: BoxShape.rectangle,
                                  color: Colors.grey[200]),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '      search',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.search),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        Card(
                          elevation: 20.0,
                          // margin: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(),
                                title: Text("${apiData.alumni.firstName} "
                                    "${apiData.alumni.lastName}"),
                                subtitle: Text(
                                  apiData.alumni.college.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.arrow_drop_down),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  apiData.discription,
                                  maxLines: _descmore ? 10 : 2,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              if (apiData.mediaUrl.isNotEmpty)
                                CarouselSlider(
                                  items: apiData.mediaUrl
                                      .map((e) => Container(
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: CachedNetworkImage(
                                              imageUrl: e.url,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.broken_image),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              fit: BoxFit.cover,
                                            ),
                                          ))
                                      .toList(),
                                  carouselController: buttonCarouselController,
                                  options: CarouselOptions(
                                      // height: 300,
                                      autoPlay: false,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      aspectRatio: 1.0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                ),
                              if (apiData.mediaUrl.length > 1)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: apiData.mediaUrl
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    return GestureDetector(
                                      onTap: () => buttonCarouselController
                                          .animateToPage(entry.key),
                                      child: Container(
                                        width: 8.0,
                                        height: 7.0,
                                        margin: EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 4.0),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                (Theme.of(context).brightness ==
                                                            Brightness.dark
                                                        ? Colors.white
                                                        : Colors.black)
                                                    .withOpacity(
                                                        _current == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        ' ${_likeuser.contains(apiData.id) ? apiData.likeCount + 1 : apiData.likeCount} like'),
                                    Text(
                                        '${apiData.comments.length < 1 ? '0' : apiData.comments.length} comment')
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton.icon(
                                      style: ButtonStyle(
                                        foregroundColor: apiData.likesUser
                                                .map((e) => e.alumni.id)
                                                .contains(value)
                                            ? MaterialStateProperty.all<Color>(
                                                Theme.of(context)
                                                    .bottomAppBarColor)
                                            : _likeuser.contains(apiData.id)
                                                ? MaterialStateProperty.all<
                                                        Color>(
                                                    Theme.of(context)
                                                        .bottomAppBarColor)
                                                : MaterialStateProperty.all<
                                                    Color>(Colors.grey),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _likeuser.contains(apiData.id)
                                              ? _likeuser.remove(apiData.id)
                                              : _likeuser.add(apiData.id);
                                        });

                                        likeDisLike(apiData.id);
                                      },
                                      icon: apiData.likesUser
                                              .map((e) => e.alumni.id)
                                              .contains(value)
                                          ? Icon(Icons.thumb_up)
                                          : _likeuser.contains(apiData.id)
                                              ? Icon(Icons.thumb_up)
                                              : Icon(
                                                  Icons.thumb_up_alt_outlined),
                                      label: Text('like')),
                                  TextButton.icon(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.grey)),
                                      label: Text('comment'),
                                      onPressed: () {
                                        if (apiData.mediaUrl.isNotEmpty)
                                          // for (var image in apiData.mediaUrl)
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      CommentScreen(
                                                          apiData.id,
                                                          apiData.likeCount,
                                                          apiData
                                                              .comments.length,
                                                          apiData.alumni
                                                                      .mediaUrl ==
                                                                  null
                                                              ? 'null'
                                                              : apiData.alumni
                                                                  .mediaUrl,
                                                          apiData.mediaUrl,
                                                          '${apiData.alumni.firstName} ${apiData.alumni.lastName}',
                                                          apiData.alumni.college
                                                              .name,
                                                          _likeuser)));
                                      },
                                      icon: Icon(Icons.comment_rounded)),
                                  TextButton.icon(
                                      style: ButtonStyle(
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.grey)),
                                      onPressed: () {},
                                      icon: Icon(Icons.send_and_archive),
                                      label: Text('share')),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]);
                    }),
              );
            }
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  )
                ]));
          }),
    );
  }
}
