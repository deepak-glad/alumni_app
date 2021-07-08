// To parse required  this JSON data, do
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
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mediaUrl,
    required this.verified,
    required this.college,
    required this.createdAt,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  dynamic mediaUrl;
  bool verified;
  College college;
  DateTime createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mediaUrl: json["MediaUrl"],
        verified: json["verified"],
        college: College.fromJson(json["college"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "MediaUrl": mediaUrl,
        "verified": verified,
        "college": college.toJson(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class College {
  College({
    required this.id,
    required this.name,
    required this.collegeCode,
    required this.city,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String name;
  String collegeCode;
  String city;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["_id"],
        name: json["name"],
        collegeCode: json["collegeCode"],
        city: json["city"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "collegeCode": collegeCode,
        "city": city,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
