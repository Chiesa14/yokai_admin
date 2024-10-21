// To parse this JSON data, do
//
//     final getAllActivity = getAllActivityFromJson(jsonString);

import 'dart:convert';

GetAllActivity getAllActivityFromJson(String str) => GetAllActivity.fromJson(json.decode(str));

String getAllActivityToJson(GetAllActivity data) => json.encode(data.toJson());

class GetAllActivity {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllActivity({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllActivity.fromJson(Map<String, dynamic> json) => GetAllActivity(
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
  String? storyId;
  String? storyName;
  String? chapterId;
  String? chapterNo;
  String? chapterName;
  String? title;
  String? time;
  String? shortDiscription;
  dynamic activityImage;
  String? documentEnglish;
  String? documentJapanese;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.storyId,
    this.storyName,
    this.chapterId,
    this.chapterNo,
    this.chapterName,
    this.title,
    this.time,
    this.shortDiscription,
    this.activityImage,
    this.documentEnglish,
    this.documentJapanese,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    storyId: json["story_id"],
    storyName: json["story_name"],
    chapterId: json["chapter_id"],
    chapterNo: json["chapter_no"],
    chapterName: json["chapter_name"],
    title: json["title"],
    time: json["time"],
    shortDiscription: json["short_discription"],
    activityImage: json["activity_image"],
    documentEnglish: json["document_english"],
    documentJapanese: json["document_japanese"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_id": storyId,
    "story_name": storyName,
    "chapter_id": chapterId,
    "chapter_no": chapterNo,
    "chapter_name": chapterName,
    "title": title,
    "time": time,
    "short_discription": shortDiscription,
    "activity_image": activityImage,
    "document_english": documentEnglish,
    "document_japanese": documentJapanese,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
