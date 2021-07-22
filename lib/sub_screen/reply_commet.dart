import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_appp/api/comment_api.dart';
import 'package:test_appp/widgets/comment_structure.dart';

class ReplyComment extends StatefulWidget {
  final String commentId;
  final String firstName;
  final String lastName;
  final String college;
  final String comment;
  final String profileImage;
  const ReplyComment(this.commentId, this.firstName, this.lastName,
      this.college, this.comment, this.profileImage);

  @override
  _ReplyCommentState createState() => _ReplyCommentState();
}

class _ReplyCommentState extends State<ReplyComment> {
  TextEditingController _editingController = new TextEditingController();
  _trySave() {
    FocusScope.of(context).unfocus();
    print(_editingController.text);
    if (_editingController.text.isNotEmpty) {
      replyComment(widget.commentId, _editingController.text);
      Navigator.of(context).pop();
    }
    _editingController.clear();
  }

  var _enteredComment = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              // padding: const EdgeInsets.all(2),
              child: Text(
                "Replies to ${widget.firstName} ${widget.lastName}'s comment on this post",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
            Divider(color: Colors.black26),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 60,
                      child: CircleAvatar()),
                  CommentStructure(widget.firstName, widget.lastName,
                      widget.college, widget.comment)
                ])
            //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            //     Container(width: 80, child: CircleAvatar()),
            //     Container(
            //       width: MediaQuery.of(context).size.width - 100,
            //       margin: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
            //       padding: const EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8.0),
            //           color: Colors.grey[200],
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black54,
            //               blurRadius: .5,
            //             ),
            //           ]),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.symmetric(vertical: 5.0),
            //                     child: Text(
            //                       "${widget.firstName} ${widget.lastName}",
            //                       style: TextStyle(
            //                           fontWeight: FontWeight.bold, fontSize: 16),
            //                     ),
            //                   ),
            //                   Text(
            //                     widget.college,
            //                     style: TextStyle(fontSize: 15),
            //                   ),
            //                   Text(
            //                     'time',
            //                     style: TextStyle(
            //                         fontWeight: FontWeight.w400, fontSize: 15),
            //                   )
            //                 ],
            //               ),
            //               IconButton(
            //                   onPressed: () {}, icon: Icon(Icons.more_vert))
            //             ],
            //           ),
            //           // Icon(Icons.more_vert),
            //           SizedBox(height: 15),

            //           Text(
            //             widget.comment,
            //             style:
            //                 TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            //           ),
            //         ],
            //       ),
            //     )
            //   ]),
          ],
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
