import '/api/profileDataApi.dart';
import '/module/connection.dart';
import 'package:flutter/material.dart';

class YourNetworkScreen extends StatefulWidget {
  @override
  _YourNetworkScreenState createState() => _YourNetworkScreenState();
}

class _YourNetworkScreenState extends State<YourNetworkScreen> {
  late Future<Welcome> _data;

  @override
  void initState() {
    _data = profileDataApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder<Welcome>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 4,
                                    width: MediaQuery.of(context).size.width,
                                    // child: Image.network(
                                    //   snapshot.data!.data[index].mediaUrl,
                                    //   fit: BoxFit.cover,
                                    // ),
                                    child: Image.asset('assets/firstpage.png'),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                            radius: 50,
                                            backgroundImage: AssetImage(
                                                'assets/profile.png')),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  "${snapshot.data!.data[index].firstName}"
                                  "${snapshot.data!.data[index].lastName}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  snapshot.data!.data[index].college.name,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Description about jobs',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text('920 connections')),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.all(8),
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            60,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Text(
                                      'Open to',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.all(8),
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            25,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.rectangle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: .5)
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                    child: Text(
                                      'Add section',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(6),
                                      margin: const EdgeInsets.all(8),
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1)
                                        ],
                                        // borderRadius: BorderRadius.all(Radius.circular(50))
                                      ),
                                      child: Icon(
                                        Icons.more_horiz,
                                        textDirection: TextDirection.rtl,
                                      )),
                                ],
                              ),
                              ListTile(
                                leading: Icon(Icons.feed),
                                title: Text('Activity'),
                                subtitle: Text('start a post'),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(Icons.connect_without_contact),
                                title: Text('Connections'),
                                subtitle:
                                    Text('see total connections you may know'),
                                trailing: Icon(Icons.arrow_forward_ios),
                                onTap: () {},
                              ),
                            ]));
                      });
                else
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ));
              })),
    );
  }
}
