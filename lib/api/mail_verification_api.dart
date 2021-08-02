import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_appp/api/verify_api.dart';
import 'package:test_appp/screen/forgetPassword.dart';

class MailVerificationApi extends StatefulWidget {
  const MailVerificationApi({Key? key}) : super(key: key);

  @override
  _MailVerificationApiState createState() => _MailVerificationApiState();
}

class _MailVerificationApiState extends State<MailVerificationApi> {
  var isLoading = false;
  _verification(String email, String choice, BuildContext cc) async {
    try {
      setState(() {
        isLoading = true;
      });
      var data = {"email": email};
      var url = Uri.parse(choice == 'Alumini'
          ? 'https://alumni-supervision.herokuapp.com/alumni/send-email'
          : 'https://alumni-supervision.herokuapp.com/user/send-email');
      http.Response response = await http.post(url,
          body: jsonEncode(data),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      if (response.statusCode == 200 && jsonResponse['status']) {
        // var otpmessage = 'OTP send successfully!';
        // ScaffoldMessenger.of(cc).showSnackBar(SnackBar(
        //   duration: Duration(seconds: 5),
        //   content: Text(otpmessage),
        //   backgroundColor: Theme.of(context).primaryColor,
        // ));
        Navigator.of(cc).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  VerifyApi(email: email, choice: choice),
            ),
            (Route<dynamic> route) => false);
        setState(() {
          isLoading = false;
        });
      } else {
        var msg = jsonResponse['message'];
        ScaffoldMessenger.of(cc).showSnackBar(SnackBar(
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
    } catch (err) {
      print(err);
      var message = 'something went wrong!';
      ScaffoldMessenger.of(cc).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text(message),
          backgroundColor: Theme.of(cc).errorColor,
        ),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgetPassword(isLoading, _verification),
    );
  }
}
