import 'dart:convert';
import '/module/eventModel.dart';
import 'package:http/http.dart' as http;

Future<Welcome> eventApi() async {
  var data;
  var url = Uri.parse('https://alumni-supervision.herokuapp.com/event/get');
  http.Response reponse = await http.get(url);
  final jsonBody = reponse.body;
  final jsonMap = jsonDecode(jsonBody);
  data = Welcome.fromJson(jsonMap);
  return data;
}

// eventDate() async {
//   Map<DateTime, List<dynamic>> _events = {};
//   var url = Uri.parse('https://alumni-supervision.herokuapp.com/event/get');
//   http.Response reponse = await http.get(url);
//   final jsonBody = reponse.body;
//   final jsonMap = jsonDecode(jsonBody);
//   var da = Welcome.fromJson(jsonMap);
//   // date = jsonMap.map((item) => Welcome.fromJson(jsonMap)).toList();
//   da.data.forEach((element) {
//     // print(element.date);
//     if (element.date != null) {
//       // arraydate.add(element.date);
//       DateTime formattedDate = DateTime.parse(DateFormat('yyyy-MM-dd')
//           .format(DateTime.parse(element.date.toString())));
//       if (_events.containsKey(formattedDate)) {
//         _events[formattedDate].add(element.date.toString());
//       } else {
//         _events[formattedDate] = [element.date.toString()];
//       }
//     }
//   });
//   print(_events);
//   return _events;
// }
