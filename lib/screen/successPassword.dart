import '/api/authentication.dart';
import 'package:flutter/material.dart';

class SuccessPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Alumini SuperVision'), centerTitle: true, elevation: 0),
      body: Container(
        child: Column(
          children: [
            // Container(
            //   child: Image.asset(
            //     'assets/success.gif',
            //     fit: BoxFit.cover,
            //     // height: 125.0,
            //     // width: 125.0,
            //   ),
            // ),
            Container(
              child: Icon(
                Icons.done,
                size: 150,
                color: Colors.green,
              ),
            ),
            Container(
                child: Text(
              'Your Passowrd has been successfully changed.please use your password to login',
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
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
      // ignore: deprecated_member_use
      // bottomNavigationBar: FlatButton(
      //     height: 40,
      //     minWidth: MediaQuery.of(context).size.width,
      //     shape: RoundedRectangleBorder(
      //         borderRadius: new BorderRadius.circular(30.0)),
      //     color: Theme.of(context).primaryColor,
      //     onPressed: () {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
      //         builder: (BuildContext context) => Authe(),
      //       ));
      //     },
      //     child: Text(
      //       'Sign IN',
      //       style: TextStyle(
      //           color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
      //     )),
    );
  }
}
