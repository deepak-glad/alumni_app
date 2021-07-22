import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                    // _name = value!;
                  },
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'first name',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)))),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                ),
                TextFormField(
                  key: ValueKey('last name'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Please enter atleast 4 characters ';
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
                          borderRadius: BorderRadius.all(Radius.circular(40)))),
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
                      prefixIcon: Icon(Icons.confirmation_number),
                      labelText: 'phone no',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)))),
                ),
              ],
            )),
      ),
    );
  }
}
