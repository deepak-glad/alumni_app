import 'dart:math';

import '/api/college_dropdown.dart';
import 'package:flutter/material.dart';

class RegisterStudent extends StatefulWidget {
  RegisterStudent(this.submitFn, this.issLoading);
  final bool issLoading;
  final void Function(String name, String lastname, String rollno, String cgID,
      String email, String password, String phoneNo, BuildContext ctx) submitFn;
  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  var _name = '';
  var _lastname = '';
  var _rollNumber = '';
  var _collegeId;
  var _email = '';
  var _password = '';
  var _phoneNo = '';

  value(String id) async {
    _collegeId = id;
  }

  void _trysave() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && _collegeId != null) {
      _formKey.currentState!.save();
      widget.submitFn(
        _name.trim(),
        _lastname.trim(),
        _rollNumber.trim(),
        _collegeId,
        _email.trim(),
        _password.trim(),
        _phoneNo,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(
            'assets/background_login.jpg',
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Container(
                    // width: 128.0,
                    height: size.height / 2 - 100,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/menu.png',
                              color: Colors.white,
                              height: 150,
                            ),
                          ),
                          Text('ALUMINI',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5))
                        ])),
                Container(
                  height: size.height / 2 + 100,
                  width: size.width,
                  padding: const EdgeInsets.only(
                      top: 25, left: 30, right: 30, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment,
                        children: [
                          Text('Registration for student',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            key: ValueKey('first Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid first name ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Enter your first name',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            key: ValueKey('lastName'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter valid last name ';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _lastname = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: 'Enter your last Name',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            key: ValueKey('roll_number'),
                            validator: (value) {
                              if (value!.length < 10) {
                                return 'Please enter valid roll number ';
                              } else if (value.length > 13)
                                return 'Please enter valid roll number ';
                              return null;
                            },
                            onSaved: (value) {
                              _rollNumber = value!;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.confirmation_number),
                                labelText: 'Enter your roll Number',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          CollegeDropDown(value),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            key: ValueKey('email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your mail ';
                              } else if (!value.contains('@')) {
                                return 'Please enter vaid mail';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Enter your email',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            key: ValueKey('Password'),
                            controller: _pass,
                            onSaved: (value) {
                              _password = value!;
                            },
                            validator: (val) {
                              if (val!.isEmpty) return 'please enter password!';
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Enter your password',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            key: ValueKey('passwordAgain'),
                            controller: _confirmPass,
                            onSaved: (value) {
                              _password = value!;
                            },
                            validator: (val) {
                              if (val!.isEmpty) return 'Please enter password!';
                              if (val != _pass.text)
                                return 'password not match';
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Enter your confirm password',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                          ),
                          TextFormField(
                            key: ValueKey('phoneNo'),
                            onSaved: (value) {
                              _phoneNo = value!;
                            },
                            validator: (val) {
                              if (val!.length != 10)
                                return 'please valid mobile number';

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                prefix: Text('+91'),
                                prefixIcon: Icon(Icons.phone),
                                labelText: 'enter your number',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          SizedBox(height: 15),
                          // widget.isLoading
                          //     ? Center(child: CircularProgressIndicator())
                          //     :
                          // ignore: deprecated_member_use
                          FlatButton(
                              height: 40,
                              minWidth: MediaQuery.of(context).size.width,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Theme.of(context).primaryColor,
                              onPressed: _trysave,
                              child: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ]))
        ],
      ),
    );
  }
}
