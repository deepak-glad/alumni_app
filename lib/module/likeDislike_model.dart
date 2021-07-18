import 'dart:convert';

class LikeDislikeModel {
  LikeDislikeModel({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory LikeDislikeModel.fromRawJson(String str) =>
      LikeDislikeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LikeDislikeModel.fromJson(Map<String, dynamic> json) =>
      LikeDislikeModel(
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
    required this.title,
    required this.discription,
    required this.status,
    required this.likeCount,
    required this.alumni,
    required this.mediaUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.commentCount,
  });

  List<String> likesUser;
  List<String> comments;
  String id;
  String title;
  String discription;
  bool status;
  var likeCount;
  String alumni;
  List<MediaUrl> mediaUrl;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  var commentCount;

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        likesUser: List<String>.from(json["likesUser"].map((x) => x)),
        comments: List<String>.from(json["comments"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        discription: json["discription"],
        status: json["status"],
        likeCount: json["likeCount"],
        alumni: json["alumni"],
        mediaUrl: List<MediaUrl>.from(
            json["MediaUrl"].map((x) => MediaUrl.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        commentCount: json["commentCount"],
      );

  Map<String, dynamic> toJson() => {
        "likesUser": List<dynamic>.from(likesUser.map((x) => x)),
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "_id": id,
        "title": title,
        "discription": discription,
        "status": status,
        "likeCount": likeCount,
        "alumni": alumni,
        "MediaUrl": List<dynamic>.from(mediaUrl.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "commentCount": commentCount,
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
