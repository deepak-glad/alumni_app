import '/api/registration_al.dart';
import '/api/registration_student.dart';
import '/sub_screen/choiceSA.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  final Function gdd;
  CategorySelector(this.gdd);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<Category> category = [];

  var gd;

  @override
  void initState() {
    super.initState();
    category.add(new Category("Student", Icons.donut_small, false));
    category.add(new Category("Alumini", Icons.donut_large, false));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(15),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'choose who you are ?',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            height: 150,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.pinkAccent,
                    onTap: () {
                      setState(() {
                        category
                            .forEach((category) => category.isSelected = false);
                        category[index].isSelected = true;
                        gd = category[index].name;
                      });
                      widget.gdd(gd);
                    },
                    child: CustomRadio(category[index]),
                  );
                }),
          ),
          Container(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                  onPressed: gd == 'Alumini'
                      ? () {
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushNamed(RegistrationAlumini.routeName);
                        }
                      : gd == 'Student'
                          ? () {
                              Navigator.of(context).pop();
                              Navigator.of(context)
                                  .pushNamed(RegistrationStudent.routeName);
                            }
                          : null,
                  child: Text('Next')))
        ],
      ),
    );
  }
}
