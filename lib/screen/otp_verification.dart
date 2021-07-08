import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerification extends StatefulWidget {
  final void Function(String pass, String otpP) data;
  final bool isLoading;
  final String name;
  OtpVerification(this.data, this.isLoading, this.name);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final password = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var otpPin;

  _trySubmit() async {
    var isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      widget.data(password.text, otpPin);
    }
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
                'Verify user',
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
                otpPin = pin;
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
                  onPressed: () {},
                  child: Text('Re-send'),
                )
              ],
            ),
            SizedBox(height: 20),

            TextFormField(
              controller: password,
              key: ValueKey('password'),
              validator: (value) {
                if (value!.isEmpty)
                  return 'Please enter password';
                else if (value.length < 3)
                  return 'please choose strong password';
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: 'Enter new password',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
            SizedBox(height: 15),
            TextFormField(
              key: ValueKey('passwordagain'),
              validator: (value) {
                if (value!.isEmpty)
                  return 'Please enter password';
                else if (value != password.text)
                  return 'password does not match';
                return null;
              },
              // onSaved: (value) {
              //   _mail = value;
              // },
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  labelText: 'Confirm password',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
          ]),
        )),
      ),
      bottomNavigationBar: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          // ignore: deprecated_member_use
          : FlatButton(
              height: 40,
              minWidth: MediaQuery.of(context).size.width,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Theme.of(context).primaryColor,
              onPressed: _trySubmit,
              child: Text(
                'Submit',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )),
    );
  }
}
