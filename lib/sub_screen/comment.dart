import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_appp/api/comment_api.dart';
import 'package:test_appp/module/comment_model.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final likecount;
  final commentcount;
  final String profileImage;
  var image = [];
  final String name;
  final String batchYear;
  bool isLiked;

  CommentScreen(this.postId, this.likecount, this.commentcount,
      this.profileImage, this.image, this.name, this.batchYear, this.isLiked);

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
    _editingController.clear();
  }

  late Future<Comment> _future;
  void initState() {
    setState(() {
      _future = CommentGetData(widget.postId);
    });
    super.initState();
  }

  CarouselController buttonCarouselController = CarouselController();
  var _current = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.isLiked);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 130,
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: widget.profileImage != 'null'
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.profileImage))
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/profile.png'),
                              ),
                        title: Text(widget.name),
                        subtitle: Text(
                          widget.batchYear,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      // Text(widget.description, overflow: TextOverflow.visible),
                      CarouselSlider(
                        items: widget.image
                            .map((e) => Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Image.network(
                                    e.url,
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
                            Text(' ${widget.likecount} like'),
                            Text('${widget.commentcount} comment')
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                              style: ButtonStyle(
                                foregroundColor: widget.isLiked
                                    ? MaterialStateProperty.all<Color>(
                                        Theme.of(context).bottomAppBarColor)
                                    : MaterialStateProperty.all<Color>(
                                        Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  // widget.isLiked = !widget.isLiked;
                                  widget.isLiked = !widget.isLiked;
                                });
                              },
                              icon: Icon(widget.isLiked
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
                      return Container(
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text('NAme'),
                          subtitle: Text('Fresher'),
                          trailing: Text('time'),
                        ),
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
                onPressed: _enteredComment.isEmpty ? null : _trySave,
                child: Text('Post'))
          ],
        ),
      ),
    );
  }
}
