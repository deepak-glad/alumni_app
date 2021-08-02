import 'package:flutter/material.dart';
import 'package:test_appp/api/college_dropdown.dart';

class ProfileEdit extends StatefulWidget {
  final firstname;
  final lastname;
  final college;
  final description;
  final phoneno;
  // final state;
  // final country;
  ProfileEdit(this.firstname,this.lastname,this.college,this.description,this.phoneno,);

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();

  var _collegeId;

  value(String id) async {
    _collegeId = id;
  }

  @override
  Widget build(BuildContext context) {
    print(_collegeId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        title: Text("Edit Intro", style: TextStyle(color: Colors.black)),
        actions: [TextButton(onPressed: () {}, child: Text('Save'))],
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  TextFormField(
                    initialValue: 'Deepak',
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('first Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter first name ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'first name',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  TextFormField(
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('last name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter last name ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'last name',
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
                    key: ValueKey('Description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter description ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    maxLines: null,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.description),
                        labelText: 'Description',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  TextFormField(
                    key: ValueKey('phone no'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 10) {
                        return 'Please enter valid number ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        labelText: 'phone no',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  TextFormField(
                    key: ValueKey('state'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter state ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        labelText: 'state/Region',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  TextFormField(
                    key: ValueKey('country'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter country ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_searching_sharp),
                        labelText: 'country/Region',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  TextFormField(
                    key: ValueKey('company'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter company name ';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value!;
                    },
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.work),
                        labelText: 'company name',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40)))),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
