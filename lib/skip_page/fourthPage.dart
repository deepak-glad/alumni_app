import 'package:flutter/material.dart';

class FourthSkipPage extends StatelessWidget {
  static const routeName = 'fouth-page';
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
      body: Container(
        child: Column(
          children: [
            Image.asset(
              'assets/fourthpage.png',
              height: size,
              fit: BoxFit.fitHeight,
            ),
            Text(
              'MENTORING & VOLUNTEERING',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Provide professional support,guidance,motivation,emotional support and role modeling',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
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
      //       Navigator.of(context).pushNamed(HomePage.routeName);
      //     },
      //   ),
      // ]),
    );
  }
}
