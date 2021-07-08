import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_appp/api/feed_get_api.dart';
import 'package:test_appp/api/like_dislike_api.dart';
import 'package:test_appp/module/feed_get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/module/home_data.dart';
import '/sub_screen/comment.dart';
import '/sub_screen/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool like = false;
  var mediaData = [];
  List<bool> _likes = List.filled(15, false);
  var idDataLike = [];
  @override
  void initState() {
    setState(() {
      _future = feedApiData();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _future = feedApiData();
    super.didChangeDependencies();
  }

  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _future = feedApiData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Feeds>(
          future: _future,
          builder: (context, snapshot) {
            // if(snapshot.connectionState!=ConnectionState.waiting)
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
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      var apiData = snapshot.data!.data[index];
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
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
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
                                            // child: Image.network(
                                            //   e.url,
                                            // width: MediaQuery.of(context)
                                            //     .size
                                            //     .width,
                                            // fit: BoxFit.cover,
                                            // ),
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
                                        ' ${apiData.likeCount == null ? '0' : idDataLike.length} like'),
                                    Text(
                                        '${apiData.comments.length < 1 ? '0' : apiData.likeCount} comment')
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton.icon(
                                      style: ButtonStyle(
                                        foregroundColor: !_likes[index]
                                            ? MaterialStateProperty.all<Color>(
                                                Colors.grey)
                                            : MaterialStateProperty.all<Color>(
                                                Theme.of(context)
                                                    .bottomAppBarColor),
                                      ),
                                      onPressed: () {
                                        if (idDataLike.isNotEmpty)
                                          idDataLike.forEach((element) {
                                            print('d');
                                            likeDisLike(element);
                                          });
                                        setState(() {
                                          _likes[index] = !_likes[index];
                                        });
                                        _likes[index]
                                            ? idDataLike.add(apiData.id)
                                            : idDataLike.remove(apiData.id);
                                        print(idDataLike.length);

                                        // likeDisLike(apiData.id);
                                      },
                                      icon: !_likes[index]
                                          ? Icon(Icons.thumb_up_alt_outlined)
                                          : Icon(Icons.thumb_up),
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
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CommentScreen(
                                                      apiData.id,
                                                      apiData.likeCount == null
                                                          ? '0'
                                                          : idDataLike.length,
                                                      apiData.comments.length <
                                                              1
                                                          ? '0'
                                                          : apiData.likeCount,
                                                      apiData.alumni.mediaUrl ==
                                                              null
                                                          ? 'null'
                                                          : apiData
                                                              .alumni.mediaUrl,
                                                      apiData.mediaUrl,
                                                      '${apiData.alumni.firstName} ${apiData.alumni.lastName}',
                                                      apiData
                                                          .alumni.college.name,
                                                      _likes[index])));
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
