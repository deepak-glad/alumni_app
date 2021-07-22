import '/api/authentication.dart';
import 'package:flutter/material.dart';

class SuccessPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2 - 50,
              child: Icon(
                Icons.verified,
                color: Colors.white,
                size: 80,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              height: MediaQuery.of(context).size.height / 2 - 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Great',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Your Passowrd has been successfully changed.please use your password to login!',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: const EdgeInsets.all(8.0),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute<void>(
                            builder: (BuildContext context) => Authe(),
                          ));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
