// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.collegeCode,
    required this.city,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String name;
  String collegeCode;
  City city;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        collegeCode: json["collegeCode"],
        city: City.fromJson(json["city"]),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "collegeCode": collegeCode,
        "city": city.toJson(),
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class City {
  City({
    required this.id,
    required this.name,
    required this.state,
  });

  String id;
  String name;
  String state;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"],
        name: json["name"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "state": state,
      };
}
