import 'package:test_appp/api/feed_get_api.dart';
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
    setState(() {
      feedApiData();
    });
  }

  CarouselController buttonCarouselController = CarouselController();
  var _current = 0;
  bool _descmore = false;
  bool like = false;
  var mediaData = [];
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
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.length,
                    itemBuilder: (context, index) {
                      var apiData = snapshot.data!.data[index];
                      // print(apiData.alumni.mediaUrl);
                      for (var image in apiData.mediaUrl) mediaData.add(image);
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
                              // InkWell(
                              //   onTap: () {
                              //     setState(() {
                              //       _descmore = !_descmore;
                              //     });
                              //   },
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: <Widget>[
                              //       _descmore
                              //           ? Text(
                              //               "Show Less",
                              //               style: TextStyle(
                              //                   color: Theme.of(context)
                              //                       .primaryColor),
                              //             )
                              //           : Text("Show More",
                              //               style: TextStyle(
                              //                   color: Theme.of(context)
                              //                       .primaryColor))
                              //     ],
                              //   ),
                              // ),
                              // if (apiData.mediaUrl.isNotEmpty)
                              // for (var image in apiData.mediaUrl)
                              //     Image.network(
                              //       image.url,
                              //       height:
                              //           MediaQuery.of(context).size.height / 2 -
                              //               20,
                              //       fit: BoxFit.fitWidth,
                              //       width: MediaQuery.of(context).size.width,
                              //     ),
                              // CarouselSlider(
                              //   items: apiData.mediaUrl
                              // .map((e) => Container(
                              //       child: Image.network(e.url),
                              //     ))
                              // .toList(),
                              //   carouselController: buttonCarouselController,
                              //   options: CarouselOptions(
                              //     autoPlay: true,
                              //     enlargeCenterPage: true,
                              //     viewportFraction: 0.9,
                              //     aspectRatio: 2.0,
                              //     initialPage: 2,
                              //     enableInfiniteScroll: false,
                              //   ),
                              // ),
                              // RaisedButton(
                              //   onPressed: () =>
                              //       buttonCarouselController.nextPage(
                              //           duration: Duration(milliseconds: 100),
                              //           curve: Curves.linear),
                              //   child: Text('→'),
                              // ),
                              CarouselSlider(
                                items: apiData.mediaUrl
                                    .map((e) => Container(
                                          color: Theme.of(context).primaryColor,
                                          child: Image.network(
                                            e.url,
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
                                        ' ${apiData.likeCount == null ? '0' : apiData.likeCount} like'),
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
                                        foregroundColor: like
                                            ? MaterialStateProperty.all<Color>(
                                                Theme.of(context)
                                                    .bottomAppBarColor)
                                            : MaterialStateProperty.all<Color>(
                                                Colors.grey),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          like = !like;
                                        });
                                      },
                                      icon: !like
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
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      CommentScreen(
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
                                                          like)));
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
