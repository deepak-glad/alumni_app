import 'dart:convert';

import '/screen/otp_verification.dart';
import '/screen/successPassword.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {
  final String name;
  final String id;
  final String choice;
  Otp(this.name, this.id, this.choice);
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var isLoading = false;

  _onsubmit(String password, var otpPin) async {
    setState(() {
      isLoading = true;
    });
    var data = {
      "resetPasswordToken": widget.id,
      "password": password,
      "otpEmail": otpPin
    };
    var url = Uri.parse(widget.choice == 'Alumini'
        ? 'https://alumni-supervision.herokuapp.com/alumni/reset'
        : 'https://alumni-supervision.herokuapp.com/user/reset');
    http.Response response = await http.post(url,
        body: jsonEncode(data),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);

    if (response.statusCode == 200 && jsonResponse['status']) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => SuccessPassword(),
        ),
      );
      // Alert(
      //   context: context,
      //   type: AlertType.warning,
      //   title: "Success",
      //   desc: "CONGRATULATION! YOU HAVE SUCCEESSFULLY CHANGE YOUR PASSWORD",
      //   buttons: [
      //     DialogButton(
      //         child: Text(
      //           "LOGIN",
      //           style: TextStyle(color: Colors.white, fontSize: 20),
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pushReplacement(
      //             MaterialPageRoute<void>(
      //               builder: (BuildContext context) => Authe(),
      //             ),
      //           );
      //         }),
      //   ],
      // ).show();
      setState(() {
        isLoading = false;
      });
    } else {
      var msg = jsonResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OtpVerification(_onsubmit, isLoading, widget.name);
  }
}
