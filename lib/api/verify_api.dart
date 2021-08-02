import 'package:flutter/material.dart';
import 'package:test_appp/screen/successfully_registered.dart';
import 'package:test_appp/screen/verify_register.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VerifyApi extends StatefulWidget {
  final String email;
  final String choice;
  const VerifyApi({required this.email, required this.choice});

  @override
  _VerifyApiState createState() => _VerifyApiState();
}

class _VerifyApiState extends State<VerifyApi> {
  var isLoading = false;

  _onsubmit(String otpPin) async {
    setState(() {
      isLoading = true;
    });
    var data = {"tokenValue": otpPin, "email": widget.email};
    var url = Uri.parse(widget.choice == 'Alumini'
        ? 'https://alumni-supervision.herokuapp.com/alumni/verify'
        : 'https://alumni-supervision.herokuapp.com/user/verify');
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
          builder: (BuildContext context) => SuccessfullyRegistered(),
        ),
      );
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
    return VerifiRegister(
      choice: widget.choice,
      name: widget.email,
      isLoading: isLoading,
      data: _onsubmit,
    );
  }
}
