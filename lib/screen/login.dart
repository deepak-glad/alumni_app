import '/api/forget.dart';
import '/widgets/registerBychoice.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, bool reme, String choice,
      BuildContext ctx) submitFn;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final usernameController = new TextEditingController();
  // final passwordController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var _username = '';
  var _password = '';
  bool rememberme = false;
  bool _showPassword = false;
  var cho;
  late String _select;
  void _selectalumniniORstudent(String select) {
    _select = select;
  }

  void _trysave() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    await Alert(
      context: context,
      type: AlertType.info,
      title: "Please choice who you are",
      // desc: "PLEASE ENTER FULL DETAILS.",
      buttons: [
        DialogButton(
            color: Theme.of(context).primaryColor,
            splashColor: Colors.amber,
            child: Text(
              "Alumni",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                cho = 'Alumni';
              });
              Navigator.of(context).pop();
            }),
        DialogButton(
            splashColor: Colors.amber,
            color: Theme.of(context).primaryColor,
            child: Text("Student",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                )),
            onPressed: () {
              setState(() {
                cho = 'student';
              });
              Navigator.of(context).pop();
            })
      ],
    ).show();
    if (isValid && cho != null && cho != 'null') {
      _formKey.currentState!.save();
      widget.submitFn(
        _username.trim(),
        _password.trim(),
        rememberme,
        cho,
        context,
      );
      cho = 'null';
    } else {
      var d = 'please choice one category';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
        content: Text(d),
        backgroundColor: Theme.of(context).errorColor,
      ));
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
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Welcome',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                          Text(
                            'Please login with your information',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          ),
                          SizedBox(height: 40),
                          // Text('Username',
                          //     style: TextStyle(
                          //         fontSize: 18, color: Colors.black38)),
                          TextFormField(
                            initialValue: 'deepakyadav1025@gmail.com',
                            // controller: usernameController,
                            key: ValueKey('username'),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Please enter atleast 4 characters ';
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                labelText: 'USERNAME',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          SizedBox(height: 30),

                          TextFormField(
                            initialValue: '123456',
                            // controller: passwordController,
                            key: ValueKey('password'),
                            validator: (value) {
                              if (value!.isEmpty)
                                return 'Please enter password';
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                            obscureText: !this._showPassword,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                    icon: Icon(Icons.remove_red_eye,
                                        color: this._showPassword
                                            ? Colors.blue
                                            : Colors.grey),
                                    onPressed: () {
                                      setState(() => this._showPassword =
                                          !this._showPassword);
                                    }),
                                labelText: 'PASSWORD',
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    checkColor: Colors.greenAccent,
                                    activeColor: Theme.of(context).cardColor,
                                    value: this.rememberme,
                                    onChanged: (var value) {
                                      setState(() {
                                        this.rememberme = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Remember me!',
                                    style: TextStyle(fontSize: 17.0),
                                  ),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(ForgetPasswordApi.routename);
                                  },
                                  child: Text('Forget Password?'))
                            ],
                          ),
                          Container(
                            width: size.width,
                            height: 42,
                            margin: const EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              // onPressed: () {
                              //   setState(() {
                              //     _future = signInMethod(
                              //         usernameController.text,
                              //         passwordController.text,
                              //         context);
                              //   });
                              // },

                              onPressed: _trysave,
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                                elevation: 5,
                                minimumSize: size / 3,
                                // alignment: Alignment.center,
                                primary: Theme.of(context).primaryColor,
                                onPrimary: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (cxt) => CategorySelector(
                                      _selectalumniniORstudent));
                            },
                            child: Text('or Register'),
                            style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w500),
                                alignment: Alignment.center),
                          )
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
