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
    required this.title,
    required this.description,
    required this.eventCode,
    required this.venue,
    required this.date,
    required this.alumnis,
    required this.mediaUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String title;
  String description;
  String eventCode;
  String venue;
  DateTime date;
  dynamic alumnis;
  List<dynamic> mediaUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        eventCode: json["eventCode"],
        venue: json["venue"],
        date: DateTime.parse(json["date"]),
        alumnis: json["alumnis"],
        mediaUrl: List<dynamic>.from(json["MediaUrl"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "eventCode": eventCode,
        "venue": venue,
        "date": date.toIso8601String(),
        "alumnis": alumnis,
        "MediaUrl": List<dynamic>.from(mediaUrl.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
