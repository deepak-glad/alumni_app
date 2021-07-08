// To parse this JSON data, do
//
//     final feeds = feedsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Feeds {
  Feeds({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datum> data;

  factory Feeds.fromRawJson(String str) => Feeds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feeds.fromJson(Map<String, dynamic> json) => Feeds(
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
    required this.likesUser,
    required this.comments,
    required this.id,
    required this.title,
    required this.discription,
    required this.likeCount,
    required this.alumni,
    required this.mediaUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  List<dynamic> likesUser;
  List<dynamic> comments;
  String id;
  String title;
  String discription;
  dynamic likeCount;
  Alumni alumni;
  List<MediaUrl> mediaUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        likesUser: List<dynamic>.from(json["likesUser"].map((x) => x)),
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        discription: json["discription"],
        likeCount: json["likeCount"],
        alumni: Alumni.fromJson(json["alumni"]),
        mediaUrl: List<MediaUrl>.from(
            json["MediaUrl"].map((x) => MediaUrl.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "likesUser": List<dynamic>.from(likesUser.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "_id": id,
        "title": title,
        "discription": discription,
        "likeCount": likeCount,
        "alumni": alumni.toJson(),
        "MediaUrl": List<dynamic>.from(mediaUrl.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Alumni {
  Alumni({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.alumni,
    required this.mediaUrl,
    required this.college,
  });

  String id;
  String firstName;
  String lastName;
  bool alumni;
  dynamic mediaUrl;
  College college;

  factory Alumni.fromRawJson(String str) => Alumni.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alumni.fromJson(Map<String, dynamic> json) => Alumni(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        alumni: json["alumni"],
        mediaUrl: json["MediaUrl"],
        college: College.fromJson(json["college"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "alumni": alumni,
        "MediaUrl": mediaUrl,
        "college": college.toJson(),
      };
}

class College {
  College({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory College.fromRawJson(String str) => College.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class MediaUrl {
  MediaUrl({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory MediaUrl.fromRawJson(String str) =>
      MediaUrl.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaUrl.fromJson(Map<String, dynamic> json) => MediaUrl(
        id: json["_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
      };
}
