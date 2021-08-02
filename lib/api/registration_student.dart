import 'dart:convert';
import 'package:test_appp/api/verify_api.dart';

import '/module/registerErr.dart';
import '/screen/register_student.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'mail_verification_api.dart';

class RegistrationStudent extends StatefulWidget {
  static const routeName = 'register-Student';
  @override
  _RegistrationStudentState createState() => _RegistrationStudentState();
}

class _RegistrationStudentState extends State<RegistrationStudent> {
  buildShowDialog(BuildContext context) {
    // if (widget.isLoading) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  backgroundColor: Colors.white,
                  content: SizedBox(
                    height: 100,
                    width: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )));
        });
  }

  bool isLoading = false;
  registerMethod(String name, String lastname, String rollno, String cgID,
      String email, String password, String phoneNo, BuildContext cc) async {
    buildShowDialog(cc);
    try {
      setState(() {
        isLoading = true;
      });
      var data = {
        "firstName": name,
        "lastName": lastname,
        "rollNo": rollno,
        "collegeId": cgID,
        "email": email,
        "password": password,
        "phoneNo": phoneNo,
      };
      var url =
          Uri.parse('https://alumni-supervision.herokuapp.com/user/register');
      http.Response response = await http.post(url,
          body: jsonEncode(data),
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
      var da = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200 && da['status'] == true) {
        return Navigator.of(cc).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  VerifyApi(email: email, choice: 'user'),
            ),
            (Route<dynamic> route) => false);
      } else if (da['message'] == 'Verify Your Account Credentials') {
        Navigator.of(cc).pop();
        var res = 'Verify Your Account Credentials';
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(res),
            backgroundColor: Theme.of(cc).errorColor,
            action: SnackBarAction(
              label: 'Verify',
              onPressed: () {
                Navigator.of(cc).push(MaterialPageRoute(
                  builder: (BuildContext context) => MailVerificationApi(),
                ));
              },
              textColor: Colors.blue,
            ),
          ),
        );
        setState(() {
          isLoading = false;
        });
      } else {
        Navigator.of(cc).pop();
        var user = Welcome.fromJson(userMap);
        var res = user.errors[0].msg;
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(res.toString()),
            backgroundColor: Theme.of(cc).errorColor,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (err) {
      Navigator.of(cc).pop();
      var message = 'cannot registered';
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
      body: RegisterStudent(registerMethod, isLoading),
    );
  }
}
