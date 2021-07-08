import '/module/home_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        Navigator.of(context).pop();
        // close(context, null);
      },
    );
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    final conatainTitle = Provider.of<HomeDataProvider>(context, listen: false);
    final data = conatainTitle.data;
    return throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final conatainTitle = Provider.of<HomeDataProvider>(context, listen: false);
    final data = conatainTitle.data;

    final product = [
      for (int i = 0; i < data.length; i++) data[i].name,
    ];
    final suggestionList = query.isEmpty
        ? product
        // : product.where((element) => element.startsWith(query)).toList();
        : product.where((element) {
            // var l = query.toLowerCase();
            // var u = query.toUpperCase();
            return element.startsWith(query);
            // else if (element.startsWith(query.toUpperCase()))
            //   return element.startsWith(query);
            // return element.startsWith(query);
          }).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        selected: true,
        onTap: () {
          showResults(context);
          // Navigator.of(context).pushNamed(
          //   .routeName,
          //   arguments: data[index].id,
          // );
        },
        leading: Icon(
          Icons.person,
          color: Theme.of(context).disabledColor,
        ),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    )),
              ]),
        ),
      ),
    );
  }
}
