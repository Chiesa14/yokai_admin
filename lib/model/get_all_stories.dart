// To parse this JSON data, do
//
//     final getAllStory = getAllStoryFromJson(jsonString);

import 'dart:convert';

GetAllStory getAllStoryFromJson(String str) => GetAllStory.fromJson(json.decode(str));

String getAllStoryToJson(GetAllStory data) => json.encode(data.toJson());

class GetAllStory {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllStory({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllStory.fromJson(Map<String, dynamic> json) => GetAllStory(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? description;
  String? storiesImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? chapterCount;
  int? activityCount;

  Datum({
    this.id,
    this.name,
    this.description,
    this.storiesImage,
    this.createdAt,
    this.updatedAt,
    this.chapterCount,
    this.activityCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    storiesImage: json["stories_image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    chapterCount: json["chapter_count"],
    activityCount: json["activity_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "stories_image": storiesImage,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "chapter_count": chapterCount,
    "activity_count": activityCount,
  };
}
