import '/api/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessfullyRegistered extends StatelessWidget {
  // static const routeName = 'Successfully_Registered';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Alumni Supervision'),
      // ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Icon(Icons.done, size: 200),
              Image.asset('assets/success.gif'),
              Container(
                  child: Text(
                'You have successfully registered with us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text('Please login for more'),
              ),
              // SizedBox(height: 50),
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute<void>(
                      builder: (BuildContext context) => Authe(),
                    ));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
