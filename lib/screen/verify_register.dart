import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class VerifiRegister extends StatefulWidget {
  final String choice;
  final String name;
  final bool isLoading;
  final void Function(String otpin) data;
  VerifiRegister(
      {required this.choice,
      required this.name,
      required this.isLoading,
      required this.data});
  @override
  _VerifiRegisterState createState() => _VerifiRegisterState();
}

class _VerifiRegisterState extends State<VerifiRegister> {
  final password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var otpPin;

  _trySubmit() async {
    var isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid && otpPin != null) {
      widget.data(otpPin);
    }
  }

//for resend otp pin to mail

  var isLoadingResend = false;

  _resend() async {
    setState(() {
      isLoadingResend = true;
    });
    var data = {"email": widget.name};
    var url = Uri.parse(widget.choice == 'Alumini'
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
      var otpmessage = 'OTP send successfully!';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(otpmessage),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoadingResend = false;
      });
    } else {
      var msg = jsonResponse['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 5),
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        isLoadingResend = false;
      });
    }
    setState(() {
      isLoadingResend = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Verify ${widget.choice}',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              'We have sent varification code to your mailId for verification',
              overflow: TextOverflow.visible,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
            ),
            Row(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 19),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Edit'),
                )
              ],
            ),
            // SizedBox(height: 10),
            // TextField(),
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onChanged: (value) => null,
              onCompleted: (pin) {
                setState(() {
                  otpPin = pin;
                });
                print("Completed: " + pin);
              },
            ),
            Row(
              children: [
                Text(
                  "Didn't receive the code ?",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: _resend,
                  child: Text('Re-send'),
                )
              ],
            ),
          ]),
        )),
      ),
      bottomNavigationBar: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              // ignore: deprecated_member_use
              child: FlatButton(
                  height: 40,
                  minWidth: MediaQuery.of(context).size.width,
                  // padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  onPressed: otpPin != null ? _trySubmit : () {},
                  child: Text(
                    otpPin != null ? 'Submit' : 'Enter Pin First',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  )),
            ),
    );
  }
}
