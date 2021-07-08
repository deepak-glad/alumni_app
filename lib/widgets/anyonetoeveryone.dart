import 'package:flutter/material.dart';

class AnyoneToEveryOne extends StatefulWidget {
  final void Function(int data) da;
  AnyoneToEveryOne(this.da);
  @override
  State<AnyoneToEveryOne> createState() => _AnyoneToEveryOneState();
}

class _AnyoneToEveryOneState extends State<AnyoneToEveryOne> {
  var _radioValue;

  _onchang(var value) {
    setState(() {
      _radioValue = value;
      widget.da(_radioValue);
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Column(
        children: [
          ListTile(
            title: Text('Who can see this post?'),
            subtitle:
                Text('Your post wiil be visible on feed,on your ptofile '),
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Anyone'),
            subtitle: Text('Anyone student or alumni'),
            trailing:
                Radio(value: 0, groupValue: _radioValue, onChanged: _onchang),
          ),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Connection Only'),
              subtitle: Text('Connections on you are added with'),
              trailing: Radio(
                  value: 1, groupValue: _radioValue, onChanged: _onchang)),
        ],
      ),
    );
  }
}
