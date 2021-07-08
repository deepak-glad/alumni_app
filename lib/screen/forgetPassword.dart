import '/widgets/forgetbychoice.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  final bool isLoading;
  final void Function(String mail, String choice, BuildContext ctx) submitFn;
  ForgetPassword(this.isLoading, this.submitFn);
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final mailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String select;
  void _selectalumniniORstudent(String sel) {
    select = sel;
  }

  _onsubmit() {
    final check = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (check) {
      _formKey.currentState!.save();
      widget.submitFn(
        mailController.text,
        select,
        context,
      );
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
              'Enter mail Id for verification',
              overflow: TextOverflow.visible,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            ForgetByChoice(_selectalumniniORstudent),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: mailController,
                key: ValueKey('mail'),
                validator: (value) {
                  if (value!.isEmpty ||
                      !value.contains('@') ||
                      value.length < 3)
                    return 'Please enter valid mail';
                  else if (select == null) return 'please choice one category';
                  return null;
                },
                // onSaved: (value) {
                //   _mail = value;
                // },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.verified_user),
                    labelText: 'Email Id',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)))),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: widget.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                maintainBottomViewPadding: true,
                // ignore: deprecated_member_use
                child: FlatButton(
                    height: 40,
                    // minWidth: MediaQuery.of(context).size.width,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(35.0)),
                    color: Theme.of(context).primaryColor,
                    onPressed: _onsubmit,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ),
    );
  }
}
