import 'dart:convert';
import '/module/registerErr.dart';
import '/screen/otp_verification.dart';
import '/screen/register_student.dart';
import '/screen/successPassword.dart';
import '/screen/successfully_registered.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class RegistrationStudent extends StatefulWidget {
  static const routeName = 'register-Student';
  @override
  _RegistrationStudentState createState() => _RegistrationStudentState();
}

class _RegistrationStudentState extends State<RegistrationStudent> {
  bool isLoading = false;
  registerMethod(String name, String lastname, String rollno, String cgID,
      String email, String password, String phoneNo, BuildContext cc) async {
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
      // print(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      if (response.statusCode == 200 && da['status'] == true) {
        return Navigator.of(cc).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => SuccessfullyRegistered(),
            ),
            (Route<dynamic> route) => false);
      } else {
        var user = Welcome.fromJson(userMap);
        var res = user.errors[0].msg;
        ScaffoldMessenger.of(cc).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 5),
            content: Text(res),
            backgroundColor: Theme.of(cc).errorColor,
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (err) {
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
