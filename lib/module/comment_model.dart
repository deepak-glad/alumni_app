// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Comment {
  Comment({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.likesUser,
    required this.comments,
    required this.id,
    required this.likeCount,
    required this.commentCount,
  });

  List<dynamic> likesUser;
  List<CommentElement> comments;
  String id;
  int likeCount;
  int commentCount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        likesUser: List<dynamic>.from(json["likesUser"].map((x) => x)),
        comments: List<CommentElement>.from(
            json["comments"].map((x) => CommentElement.fromJson(x))),
        id: json["_id"],
        likeCount: json["likeCount"],
        commentCount: json["commentCount"],
      );

  Map<String, dynamic> toJson() => {
        "likesUser": List<dynamic>.from(likesUser.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "_id": id,
        "likeCount": likeCount,
        "commentCount": commentCount,
      };
}

class CommentElement {
  CommentElement({
    required this.replies,
    required this.id,
    required this.user,
    required this.alumni,
    required this.comment,
    required this.post,
  });

  List<dynamic> replies;
  String id;
  dynamic user;
  Alumni alumni;
  String comment;
  String post;

  factory CommentElement.fromRawJson(String str) =>
      CommentElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentElement.fromJson(Map<String, dynamic> json) => CommentElement(
        replies: List<dynamic>.from(json["replies"].map((x) => x)),
        id: json["_id"],
        user: json["user"],
        alumni: json["alumni"] == null
            ? Alumni.fromJson(json["user"])
            : Alumni.fromJson(json["alumni"]),
        comment: json["comment"],
        post: json["post"],
      );

  Map<String, dynamic> toJson() => {
        "replies": List<dynamic>.from(replies.map((x) => x)),
        "_id": id,
        "user": user,
        "alumni": alumni.toJson(),
        "comment": comment,
        "post": post,
      };
}

class Alumni {
  Alumni({
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
  String college;

  factory Alumni.fromRawJson(String str) => Alumni.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alumni.fromJson(Map<String, dynamic> json) => Alumni(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        college: json["college"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "college": college,
      };
}
