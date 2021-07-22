// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

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
    required this.createdAt,
    required this.updatedAt,
    required this.commentCount,
  });

  List<LikesUser> likesUser;
  List<CommentElement> comments;
  String id;
  var likeCount;
  DateTime createdAt;
  DateTime updatedAt;
  var commentCount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        likesUser: List<LikesUser>.from(
            json["likesUser"].map((x) => LikesUser.fromJson(x))),
        comments: List<CommentElement>.from(
            json["comments"].map((x) => CommentElement.fromJson(x))),
        id: json["_id"],
        likeCount: json["likeCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        commentCount: json["commentCount"],
      );

  Map<String, dynamic> toJson() => {
        "likesUser": List<dynamic>.from(likesUser.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "_id": id,
        "likeCount": likeCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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
    required this.createdAt,
    required this.updatedAt,
    required this.replyCount,
  });

  List<Reply> replies;
  String id;
  dynamic user;
  Alumni alumni;
  String comment;
  String post;
  DateTime createdAt;
  DateTime updatedAt;
  var replyCount;

  factory CommentElement.fromRawJson(String str) =>
      CommentElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentElement.fromJson(Map<String, dynamic> json) => CommentElement(
        replies:
            List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
        id: json["_id"],
        user: json["user"],
        alumni: json["alumni"] == null
            ? Alumni.fromJson(json["user"])
            : Alumni.fromJson(json["alumni"]),
        comment: json["comment"],
        post: json["post"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        replyCount: json["replyCount"] == null ? null : json["replyCount"],
      );

  Map<String, dynamic> toJson() => {
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
        "_id": id,
        "user": user,
        "alumni": alumni.toJson(),
        "comment": comment,
        "post": post,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "replyCount": replyCount == null ? null : replyCount,
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
  College college;

  factory Alumni.fromRawJson(String str) => Alumni.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alumni.fromJson(Map<String, dynamic> json) => Alumni(
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

class Reply {
  Reply({
    required this.id,
    required this.user,
    required this.alumni,
    required this.reply,
  });

  String id;
  dynamic user;
  Alumni alumni;
  String reply;

  factory Reply.fromRawJson(String str) => Reply.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["_id"],
        user: json["user"],
        alumni: json["alumni"] == null
            ? Alumni.fromJson(json["user"])
            : Alumni.fromJson(json["alumni"]),
        reply: json["reply"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "alumni": alumni.toJson(),
        "reply": reply,
      };
}

class LikesUser {
  LikesUser({
    required this.id,
    required this.user,
    required this.alumni,
    required this.post,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  var user;
  var alumni;
  String post;
  DateTime createdAt;
  DateTime updatedAt;
  var v;

  factory LikesUser.fromRawJson(String str) =>
      LikesUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LikesUser.fromJson(Map<String, dynamic> json) => LikesUser(
        id: json["_id"],
        user: json["user"],
        alumni: json["alumni"] == null
            ? Alumni.fromJson(json["user"])
            : Alumni.fromJson(json["alumni"]),
        post: json["post"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user == null ? null : user.toJson(),
        "alumni": alumni == null ? null : alumni.toJson(),
        "post": post,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
