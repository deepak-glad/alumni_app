// To parse this JSON data, do
//
//     final pending = pendingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Pending pendingFromJson(String str) => Pending.fromJson(json.decode(str));

String pendingToJson(Pending data) => json.encode(data.toJson());

class Pending {
  Pending({
    required this.status,
    required this.invitationSend,
    required this.invitaionReceived,
  });

  bool status;
  List<Invita> invitationSend;
  List<Invita> invitaionReceived;

  factory Pending.fromJson(Map<String, dynamic> json) => Pending(
        status: json["status"],
        invitationSend: List<Invita>.from(
            json["invitationSend"].map((x) => Invita.fromJson(x))),
        invitaionReceived: List<Invita>.from(
            json["invitaionReceived"].map((x) => Invita.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "invitationSend":
            List<dynamic>.from(invitationSend.map((x) => x.toJson())),
        "invitaionReceived":
            List<dynamic>.from(invitaionReceived.map((x) => x.toJson())),
      };
}

class Invita {
  Invita({
    required this.target,
    required this.id,
    required this.user,
    required this.targetUser,
    required this.connect,
    required this.blocked,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Target target;
  String id;
  String user;
  String targetUser;
  bool connect;
  bool blocked;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Invita.fromJson(Map<String, dynamic> json) => Invita(
        target: Target.fromJson(json["target"]),
        id: json["_id"],
        user: json["user"],
        targetUser: json["targetUser"],
        connect: json["connect"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "target": target.toJson(),
        "_id": id,
        "user": user,
        "targetUser": targetUser,
        "connect": connect,
        "blocked": blocked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Target {
  Target({
    required this.firstName,
    required this.lastName,
    required this.mediaUrl,
  });

  String firstName;
  String lastName;
  dynamic mediaUrl;

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        firstName: json["firstName"],
        lastName: json["lastName"],
        mediaUrl: json["MediaUrl"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "MediaUrl": mediaUrl,
      };
}
