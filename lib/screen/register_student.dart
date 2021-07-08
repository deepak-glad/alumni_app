import '/api/college_dropdown.dart';
import 'package:flutter/material.dart';

class RegisterStudent extends StatefulWidget {
  RegisterStudent(this.submitFn, this.isLoading);
  final bool isLoading;
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

    if (isValid) {
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
                widget.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
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
                                  key: ValueKey('first Name'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter atleast 4 characters ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'first name',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('lastName'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter atleast 4 characters ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _lastname = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'Last Name',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('roll_number'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter atleast 4 characters ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _rollNumber = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.confirmation_number),
                                      labelText: 'Roll Number',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                CollegeDropDown(value),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('username'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'Please enter atleast 4 characters ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      labelText: 'email',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
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
                                    if (val!.isEmpty) return 'Empty';
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: 'Enter password',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
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
                                    if (val!.isEmpty) return 'Empty';
                                    if (val != _pass.text) return 'not match';
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: 'confirm your password',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('phoneNo'),
                                  onSaved: (value) {
                                    _phoneNo = value!;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      labelText: 'enter your phone number',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
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
