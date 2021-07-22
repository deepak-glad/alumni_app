import '/api/college_dropdown.dart';
import '/widgets/pick_date.dart';
import 'package:flutter/material.dart';

class RegisterAlumini extends StatefulWidget {
  RegisterAlumini(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
      String name,
      String lastname,
      String rollno,
      String cgID,
      String email,
      String password,
      String phoneNo,
      String from,
      String to,
      String jobTitle,
      String jobCompany,
      String ex,
      BuildContext ctx) submitFn;
  @override
  _RegisterAluminiState createState() => _RegisterAluminiState();
}

class _RegisterAluminiState extends State<RegisterAlumini> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  var _name = '';
  var _lastname = '';
  var _rollNumber = '';
  var _collegeId = '';
  var _email = '';
  var _password = '';
  var _phoneNo = '';
  var _from = ' ';
  var _to = '';
  var _jobtitle = '';
  var _jobCompany = '';
  var _experience = '';

  value(String id) {
    _collegeId = id;
  }

  dateFrom(String date) {
    _from = date;
  }

  dateTo(String dateTO) {
    _to = dateTO;
  }

  void _trysave() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid && _collegeId != null) {
      _formKey.currentState!.save();
      print(_collegeId);
      widget.submitFn(
        _name.trim(),
        _lastname.trim(),
        _rollNumber.trim(),
        _collegeId,
        _email.trim(),
        _password.trim(),
        _phoneNo,
        _from.trim(),
        _to.trim(),
        _jobtitle.trim(),
        _jobCompany.trim(),
        _experience.trim(),
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
                                Text('Registration for Alumini',
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
                                      return 'Please enter first name ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _name = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'Please enter your first name',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  key: ValueKey('lastName'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter last name ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _lastname = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'Please enter your last Name',
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
                                    if (value!.isEmpty && value.length < 9) {
                                      return 'Please enter valid roll number ';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _rollNumber = value!;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.confirmation_number),
                                      labelText:
                                          'Please enter your roll Number',
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
                                  key: ValueKey('email'),
                                  validator: (value) {
                                    if (value!.isEmpty || value.length < 4) {
                                      return 'please enter valid mail';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value!;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      labelText: 'Please enter your email',
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
                                    if (val!.isEmpty)
                                      return 'please enter your password';
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: 'Please enter your password',
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
                                    if (val!.isEmpty)
                                      return 'please enter your password';
                                    if (val != _pass.text)
                                      return 'password does not match';
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText:
                                          'Please enter your confirm password',
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
                                  validator: (val) {
                                    if (val!.isEmpty && val.length < 9)
                                      return 'please enter valid number';
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.phone),
                                      prefixText: '+91',
                                      labelText: 'Please enter your number',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                DatePickerFrom(dateFrom),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                DatePickerTo(dateTo),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('experience'),
                                  onSaved: (value) {
                                    _experience = value!;
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'please enter your experience';
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.timelapse),
                                      labelText: 'Please enter your experience',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('jobtitle'),
                                  onSaved: (value) {
                                    _jobtitle = value!;
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'please enter your job title';
                                    return null;
                                  },
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.title),
                                      labelText: 'Please enter your Job_title',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                ),
                                TextFormField(
                                  key: ValueKey('jobcompany'),
                                  onSaved: (value) {
                                    _jobCompany = value!;
                                  },
                                  validator: (val) {
                                    if (val!.isEmpty)
                                      return 'please enter your job company';
                                    return null;
                                  },
                                  textCapitalization: TextCapitalization.words,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.business_center),
                                      labelText:
                                          'Please enter your Job_Company',
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)))),
                                ),
                                SizedBox(height: 15),
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
