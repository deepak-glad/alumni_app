import 'package:meta/meta.dart';
import 'dart:convert';

Feeds feedsFromJson(String str) => Feeds.fromJson(json.decode(str));

String feedsToJson(Feeds data) => json.encode(data.toJson());

class Feeds {
  Feeds({
    required this.status,
    required this.data,
  });

  bool status;
  List<Datum> data;

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

  List<LikesUser> likesUser;
  List<String> comments;
  String id;
  var title;
  String discription;
  int likeCount;
  DatumAlumni alumni;
  List<MediaUrl> mediaUrl;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        likesUser: List<LikesUser>.from(
            json["likesUser"].map((x) => LikesUser.fromJson(x))),
        comments: List<String>.from(json["comments"].map((x) => x)),
        id: json["_id"],
        title: titleValues.map[json["title"]],
        discription: json["discription"],
        likeCount: json["likeCount"],
        alumni: DatumAlumni.fromJson(json["alumni"]),
        mediaUrl: List<MediaUrl>.from(
            json["MediaUrl"].map((x) => MediaUrl.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "likesUser": List<dynamic>.from(likesUser.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "_id": id,
        "title": titleValues.reverse[title],
        "discription": discription,
        "likeCount": likeCount,
        "alumni": alumni.toJson(),
        "MediaUrl": List<dynamic>.from(mediaUrl.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class DatumAlumni {
  DatumAlumni({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.alumni,
    required this.mediaUrl,
    required this.college,
  });

  var id;
  var firstName;
  var lastName;
  bool alumni;
  dynamic mediaUrl;
  College college;

  factory DatumAlumni.fromJson(Map<String, dynamic> json) => DatumAlumni(
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

class LikesUser {
  LikesUser({
    required this.id,
    required this.alumni,
    required this.post,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  UserClass alumni;
  String post;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory LikesUser.fromJson(Map<String, dynamic> json) => LikesUser(
        id: json["_id"],
        alumni: json["alumni"] == null
            ? UserClass.fromJson(json["user"])
            : UserClass.fromJson(json["alumni"]),
        post: json["post"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "alumni": alumni == null ? null : alumni.toJson(),
        "post": post,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class UserClass {
  UserClass({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.college,
  });

  String id;
  String firstName;
  String lastName;
  String email;
  College college;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        college: College.fromJson(json["college"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "college": college.toJson(),
      };
}

class MediaUrl {
  MediaUrl({
    required this.id,
    required this.url,
  });

  String id;
  String url;

  factory MediaUrl.fromJson(Map<String, dynamic> json) => MediaUrl(
        id: json["_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
      };
}

enum Title { ANYONE, CONNECTION_ONLY }

final titleValues = EnumValues(
    {"anyone": Title.ANYONE, "connection Only": Title.CONNECTION_ONLY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
