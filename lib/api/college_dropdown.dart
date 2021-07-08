import 'dart:convert';

import '/module/collegeDropDown_Model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CollegeDropDown extends StatefulWidget {
  final void Function(String idd) id;
  CollegeDropDown(this.id);
  @override
  _CollegeDropDownState createState() => _CollegeDropDownState();
}

class _CollegeDropDownState extends State<CollegeDropDown> {
  late Future<Welcome> _data;
  var _dropDownValue;
  var idLocal;
  Future<Welcome> collegId() async {
    var dataDropDown;
    var url = Uri.parse('https://alumni-supervision.herokuapp.com/college/get');
    http.Response response = await http.get(url);
    final jsonString = response.body;
    final jsonMap = jsonDecode(jsonString);
    dataDropDown = Welcome.fromJson(jsonMap);
    return dataDropDown;
  }

  @override
  void initState() {
    _data = collegId();

    super.initState();
  }

  // void _save() {
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: Colors.black45)),
      padding: const EdgeInsets.all(15),
      child: FutureBuilder<Welcome>(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return DropdownButtonHideUnderline(
                child: DropdownButton(
                  hint: _dropDownValue == null
                      ? Text('choose college')
                      : Text(
                          _dropDownValue,
                          style: TextStyle(color: Colors.black),
                        ),
                  isExpanded: true,
                  iconSize: 35.0,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                  ),
                  items: List.generate(
                      snapshot.data!.data.length,
                      (index) => DropdownMenuItem<String>(
                            value: snapshot.data!.data[index].name,
                            child: Text(snapshot.data!.data[index].name),
                            onTap: () {
                              setState(() {
                                idLocal = snapshot.data!.data[index].id;
                                widget.id(idLocal);
                              });
                            },
                          )),
                  // onTap: _save,
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValue = val.toString();
                      },
                    );
                  },
                ),
              );
            else
              return Container(
                  alignment: Alignment.topRight,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ));
          }),
    );
  }
}
