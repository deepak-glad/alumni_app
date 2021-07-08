import '/api/authentication.dart';
import '/skip_page/firstPage.dart';
import '/skip_page/fourthPage.dart';
import '/skip_page/secondPage.dart';
import '/skip_page/thirdPage.dart';
import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final List<Widget> _list = [
    FirstSkipPage(),
    SecondSkipPage(),
    ThirdSkipPage(),
    FourthSkipPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    new MaterialPageRoute(builder: (context) => Authe()));
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Theme.of(context).canvasColor),
              ))
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: DefaultTabController(
          length: _list.length,
          child: Builder(
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: TabBarView(children: _list)),
                  const TabPageSelector(),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.of(context).pushReplacement(
                  //           new MaterialPageRoute(
                  //               builder: (context) => Authe()));
                  //     },
                  //     child: const Text('Next')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
