import 'package:flutter/material.dart';

class SecondSkipPage extends StatelessWidget {
  static const routeName = 'second-page';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   actions: [
      //     TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(HomePage.routeName);
      //         },
      //         child: Text(
      //           'Skip',
      //           style: TextStyle(color: Theme.of(context).canvasColor),
      //         ))
      //   ],
      // ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image.asset(
                'assets/secondpage.png',
                height: size / 2,
                fit: BoxFit.fitHeight,
              ),
              Text(
                'GROUPS',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              SizedBox(height: 20),
              Text(
                'Create or join a group for enhanced collaboration, talk about latest trends, knowledge sharing or other relevant topics',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar:
      //     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //   ElevatedButton(
      //     child: Text('Previous'),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   ElevatedButton(
      //     child: Text('Next'),
      //     onPressed: () {
      //       Navigator.of(context).pushNamed(ThirdSkipPage.routeName);
      //     },
      //   ),
      // ]),
    );
  }
}
