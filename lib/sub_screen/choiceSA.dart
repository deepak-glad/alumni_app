import 'package:flutter/material.dart';

class Category {
  String name;
  IconData icon;
  bool isSelected;
  Category(this.name, this.icon, this.isSelected);
}

class CustomRadio extends StatelessWidget {
  final Category _category;
  CustomRadio(this._category);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: _category.isSelected
            ? Color(0xFF3B4257)
            : Color.fromRGBO(255, 255, 255, 0.8),
        child: Container(
          height: 25,
          width: 85,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                _category.icon,
                color: _category.isSelected ? Colors.white : Colors.grey,
                size: 30,
              ),
              SizedBox(height: 10),
              Text(
                _category.name,
                style: TextStyle(
                    color: _category.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}
