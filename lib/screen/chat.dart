import '/module/home_data.dart';
import '/chat/message.dart';
import '/sub_screen/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<HomeDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    showSearch(context: context, delegate: DataSearch());
                  },
                  // cursorColor: Colors.white,
                  // // controller: controller,
                  // // focusNode: focusNode,
                  // style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    // enabledBorder: const OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(50)),
                    //   borderSide: BorderSide(
                    //     color: Colors.yellow,
                    //   ),
                    // ),
                    // focusedBorder: OutlineInputBorder(
                    //   borderRadius: BorderRadius.all(Radius.circular(50)),
                    //   borderSide:
                    //       BorderSide(color: Theme.of(context).primaryColor),
                    // ),
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    hintText: "Search here...",
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                      right: 20,
                      top: 14,
                      bottom: 14,
                    ),
                  ),
                ),
              ),
              // IconButton(
              //   icon: Icon(Icons.search),
              //   onPressed: () {
              //     showSearch(context: context, delegate: DataSearch());
              //   },
              // ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: dataProvider.data.length,
                itemBuilder: (context, index) => Column(children: [
                  ListTile(
                    leading: CircleAvatar(
                      foregroundImage:
                          AssetImage(dataProvider.data[index].profileImage),
                    ),
                    title: Text(dataProvider.data[index].name),
                    subtitle: Text('anything that send by sender recently'),
                    trailing: Text('sat'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => MessageScreen(
                              dataProvider.data[index].name,
                              dataProvider.data[index].profileImage,
                              dataProvider.data[index].branchandYear)));
                    },
                  ),
                  Divider(thickness: 1),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
