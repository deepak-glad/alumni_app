import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_appp/api/comment_api.dart';
import 'package:test_appp/api/like_dislike_api.dart';
import 'package:test_appp/module/comment_model.dart';
import 'package:test_appp/sub_screen/reply_commet.dart';
import 'package:test_appp/widgets/comment_structure.dart';
import 'package:test_appp/widgets/reply_commnet_structure.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final likecount;
  final commentcount;
  final String profileImage;
  final List image;
  final String firstname;
  final String lastname;
  final String collegename;
  final String description;
  final List liked;

  CommentScreen(
      this.postId,
      this.likecount,
      this.commentcount,
      this.profileImage,
      this.image,
      this.firstname,
      this.lastname,
      this.collegename,
      this.description,
      this.liked);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController _editingController = new TextEditingController();
  var _enteredComment = '';
  _trySave() {
    FocusScope.of(context).unfocus();
    print(_enteredComment);
    commentData(widget.postId, _enteredComment);
    _commentData.add(CommentElement(
        replies: [],
        id: widget.postId,
        user: Alumni(
            college: College(id: widget.postId, name: widget.collegename),
            email: '',
            firstName: name,
            id: widget.postId,
            lastName: ''),
        alumni: Alumni(
            college: College(id: widget.postId, name: widget.collegename),
            email: '',
            firstName: name,
            id: widget.postId,
            lastName: ''),
        comment: _enteredComment,
        post: widget.postId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        replyCount: 0));
    _editingController.clear();
  }

  late Future<Comment> _future;
  var _id;
  late List<CommentElement> _commentData = <CommentElement>[];
  void initState() {
    _profileData();
    _future = commentgetdata(widget.postId);
    _future.then((value) {
      setState(() {
        _id = value.data.id;
        _commentData = value.data.comments;
      });
    });
    super.initState();
  }

  var name;
  _profileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
    });
  }

  Future _onPull() async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      _future = commentgetdata(widget.postId);
    });
  }

  CarouselController buttonCarouselController = CarouselController();
  var _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 130,
        padding: const EdgeInsets.all(5.0),
        child: RefreshIndicator(
          onRefresh: _onPull,
          child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: widget.profileImage != 'null'
                            ? CircleAvatar(
                                // backgroundImage:
                                // NetworkImage(widget.profileImage)
                                )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/profile.png'),
                              ),
                        title: Text('${widget.firstname} ${widget.lastname}'),
                        subtitle: Text(
                          widget.collegename,
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
                          widget.description,
                          // maxLines: _descmore ? 10 : 2,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      if (widget.image.isNotEmpty)
                        CarouselSlider(
                          items: widget.image
                              .map((e) => Container(
                                    color: Theme.of(context).primaryColor,
                                    child: CachedNetworkImage(
                                      imageUrl: e.url,
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.broken_image),
                                      width: MediaQuery.of(context).size.width,
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
                      // if(widget.description != null)

                      if (widget.image.length > 1)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: widget.image.asMap().entries.map((entry) {
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
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                ' ${widget.liked.contains(_id) ? widget.likecount + 1 : widget.likecount} like'),
                            Text(
                                '${_commentData.isEmpty ? widget.commentcount : _commentData.length} comment')
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                              style: ButtonStyle(
                                foregroundColor: widget.liked.contains(_id)
                                    ? MaterialStateProperty.all<Color>(
                                        Theme.of(context).bottomAppBarColor)
                                    : MaterialStateProperty.all<Color>(
                                        Colors.grey),
                              ),
                              onPressed: () {
                                likeDisLike(_id);
                                setState(() {
                                  widget.liked.contains(_id)
                                      ? widget.liked.remove(_id)
                                      : widget.liked.add(_id);
                                });
                              },
                              icon: Icon(widget.liked.contains(_id)
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_alt_outlined),
                              label: Text('like')),
                          TextButton.icon(
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.grey)),
                              label: Text('comment'),
                              onPressed: () {},
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
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 5),
                  child: Text(
                    'Reactions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  height: 40,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(),
                            Icon(
                              Icons.thumb_up,
                              color: Theme.of(context).primaryColor,
                              size: 17,
                            )
                          ]),
                      SizedBox(width: 5),
                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(),
                            Icon(
                              Icons.thumb_up,
                              color: Theme.of(context).primaryColor,
                              size: 17,
                            )
                          ]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10, bottom: 5),
                  child: Text(
                    'Comments',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                FutureBuilder<Comment>(
                    future: _future,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.data.comments.length > 0) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _commentData.length,
                              itemBuilder: (context, index) {
                                var dta = _commentData[index];

                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              width: 60,
                                              child: CircleAvatar()),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommentStructure(
                                                    dta.alumni.firstName,
                                                    dta.alumni.lastName,
                                                    dta.alumni.college.name,
                                                    dta.comment),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              ReplyComment(
                                                                  dta.id,
                                                                  dta.alumni
                                                                      .firstName,
                                                                  dta.alumni
                                                                      .lastName,
                                                                  dta
                                                                      .alumni
                                                                      .college
                                                                      .name,
                                                                  dta.comment,
                                                                  widget
                                                                      .profileImage)));
                                                    },
                                                    child: Text('Reply')),
                                                if (dta.replies.isNotEmpty)
                                                  Column(
                                                      children: dta.replies
                                                          .map<Widget>((e) =>
                                                              REplyComment(
                                                                  e.alumni
                                                                      .firstName,
                                                                  e.alumni
                                                                      .lastName,
                                                                  e
                                                                      .alumni
                                                                      .college
                                                                      .name,
                                                                  e.reply))
                                                          .toList()),
                                                Divider(
                                                    height: 10,
                                                    color: Colors.black,
                                                    thickness: 5),
                                              ]),
                                        ]));
                              });
                        }
                        return Center(child: Text('Be the first to comment'));
                      } else if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('something went wrong try again later'));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ]),
        ),
      ),
      bottomSheet: Container(
        // height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: widget.profileImage != 'null'
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(widget.profileImage))
                  : CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
            ),
            Expanded(
              child: TextField(
                controller: _editingController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                autofocus: true,
                minLines: 1,
                maxLines: 7,
                decoration:
                    InputDecoration(hintText: 'Leave your throughts here...'),
                onChanged: (value) {
                  setState(() {
                    _enteredComment = value;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: _editingController.text.isEmpty ? null : _trySave,
                child: Text('Post'))
          ],
        ),
      ),
    );
  }
}
