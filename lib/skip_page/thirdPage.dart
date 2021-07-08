import 'package:flutter/material.dart';

class ThirdSkipPage extends StatelessWidget {
  static const routeName = 'third-page';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height / 2 + 50;
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
          child: Column(
            children: [
              Image.asset(
                'assets/thirdpage.png',
                height: size,
                fit: BoxFit.fitHeight,
              ),
              Text(
                'NEWS & EVENTS',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              SizedBox(height: 20),
              Text(
                'Keep up to date with the latest news from the alumnini community and network',
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
      //       Navigator.of(context).pushNamed(FourthSkipPage.routeName);
      //     },
      //   ),
      // ]),
    );
  }
}
