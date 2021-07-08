import 'dart:convert';

class ImageUpload {
  ImageUpload({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory ImageUpload.fromRawJson(String str) =>
      ImageUpload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ImageUpload.fromJson(Map<String, dynamic> json) => ImageUpload(
        status: json["status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.eTag,
    required this.versionId,
    required this.location,
    this.datumKey,
    this.key,
    this.bucket,
  });

  String eTag;
  String versionId;
  String location;
  var datumKey;
  var key;
  var bucket;

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        eTag: json["ETag"],
        versionId: json["VersionId"],
        location: json["Location"],
        datumKey: json["key"],
        key: json["Key"],
        bucket: json["Bucket"],
      );

  Map<String, dynamic> toJson() => {
        "ETag": eTag,
        "VersionId": versionId,
        "Location": location,
        "key": datumKey,
        "Key": key,
        "Bucket": bucket,
      };
}
