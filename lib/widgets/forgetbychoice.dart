import 'package:flutter/cupertino.dart';

import '/sub_screen/choiceSA.dart';
import 'package:flutter/material.dart';

class ForgetByChoice extends StatefulWidget {
  final Function gdd;
  ForgetByChoice(this.gdd);

  @override
  _ForgetByChoiceState createState() => _ForgetByChoiceState();
}

class _ForgetByChoiceState extends State<ForgetByChoice> {
  List<Category> category = [];

  late String gd;

  @override
  void initState() {
    super.initState();
    category
        .add(new Category("Student", CupertinoIcons.smallcircle_circle, false));
    category.add(new Category("Alumini", Icons.donut_large, false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(15),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            height: 100,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.pinkAccent,
                    onTap: () {
                      setState(() {
                        category
                            .forEach((category) => category.isSelected = false);
                        category[index].isSelected = true;
                        gd = category[index].name;
                      });
                      widget.gdd(gd);
                    },
                    child: CustomRadio(category[index]),
                  );
                }),
          ),
          // Container(
          //     alignment: Alignment.topRight,
          //     child: ElevatedButton(
          //         onPressed: gd == 'Alumini'
          //             ? () {
          //                 Navigator.of(context).pop();
          //                 Navigator.of(context)
          //                     .pushNamed(RegistrationAlumini.routeName);
          //               }
          //             : gd == 'Student'
          //                 ? () {
          //                     Navigator.of(context).pop();
          //                     Navigator.of(context)
          //                         .pushNamed(RegistrationStudent.routeName);
          //                   }
          //                 : null,
          //         child: Text('Next')))
        ],
      ),
    );
  }
}
