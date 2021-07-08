import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final String profileImage;
  var image = [];
  final String name;
  final String batchYear;
  bool isLiked;

  CommentScreen(
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
    _editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    for (var im in widget.image) print(im.url);
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
                      for (var im in widget.image) Image.network(im.url),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton.icon(
                              style: ButtonStyle(
                                foregroundColor: widget.isLiked
                                    ? MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColor)
                                    : MaterialStateProperty.all<Color>(
                                        Colors.grey),
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.isLiked = !widget.isLiked;
                                });
                              },
                              icon: Icon(Icons.thumb_up),
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
                Container(
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('NAme'),
                    subtitle: Text('Fresher'),
                    trailing: Text('time'),
                  ),
                )
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
