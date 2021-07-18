import 'package:flutter/material.dart';

class REplyComment extends StatelessWidget {
  final String firstname;
  final String lastName;
  final String college;
  // final String time;
  final String message;
  const REplyComment(this.firstname, this.lastName, this.college, this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              child: CircleAvatar()),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 + 75,
              margin: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: .5,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              "$firstname $lastName",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(
                              college,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Text(
                            'time',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15),
                          )
                        ],
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                    ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    message,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
          ])
        ]);
  }
}
