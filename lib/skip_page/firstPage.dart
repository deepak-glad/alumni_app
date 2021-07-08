import 'package:flutter/material.dart';

class FirstSkipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height / 2 + 50;
    return

        // backgroundColor: Theme.of(context).primaryColor,
        SafeArea(
      child: Container(
        child: Column(
          children: [
            Image.asset(
              'assets/firstpage.png',
              height: size,
              fit: BoxFit.fitHeight,
            ),
            Text(
              'GET CONNECTED',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'Grow your network by connecting with our community of ALUMINI',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      // ),
      // bottomNavigationBar: ElevatedButton(
      //   child: Text('Next'),
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(SecondSkipPage.routeName);
      //   },
      // ),
    );
  }
}
