import 'dart:convert';
import '/api/otp.dart';
import '/screen/forgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordApi extends StatefulWidget {
  static const routename = 'forgetPassword';

  @override
  _ForgetPasswordApiState createState() => _ForgetPasswordApiState();
}

class _ForgetPasswordApiState extends State<ForgetPasswordApi> {
  var isLoading = false;
  var id;
  Future onSubmit(String mail, String choice, BuildContext cc) async {
    setState(() {
      isLoading = true;
    });
    var data = {"email": mail};
    var url = Uri.parse(choice == 'Alumini'
        ? 'https://alumni-supervision.herokuapp.com/alumni/forgetPassword'
        : 'https://alumni-supervision.herokuapp.com/user/forgetPassword');
    http.Response response = await http.post(url,
        body: jsonEncode(data),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        });
    var jsonResponse = json.decode(response.body);
    setState(() {
      id = jsonResponse['data'];
    });
    if (response.statusCode == 200 && jsonResponse['status']) {
      return Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => Otp(mail, id, choice),
        ),
      );
    } else {
      var msg = jsonResponse['message'];
      ScaffoldMessenger.of(cc).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(msg),
        backgroundColor: Theme.of(cc).errorColor,
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
    return Scaffold(
      body: ForgetPassword(
        isLoading,
        onSubmit,
      ),
    );
  }
}
