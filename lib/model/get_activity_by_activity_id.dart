// To parse this JSON data, do
//
//     final getActivityById = getActivityByIdFromJson(jsonString);

import 'dart:convert';

GetActivityById getActivityByIdFromJson(String str) => GetActivityById.fromJson(json.decode(str));

String getActivityByIdToJson(GetActivityById data) => json.encode(data.toJson());

class GetActivityById {
  String? status;
  String? message;
  Data? data;

  GetActivityById({
    this.status,
    this.message,
    this.data,
  });

  factory GetActivityById.fromJson(Map<String, dynamic> json) => GetActivityById(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? storyId;
  String? storyName;
  String? chapterId;
  String? chapterName;
  String? chapterNo;
  String? title;
  String? time;
  String? shortDiscription;
  dynamic activityImage;
  dynamic image;
  dynamic audio;
  String? documentEnglish;
  dynamic documentJapanese;
  String? characterName;
  dynamic endImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Detail>? details;

  Data({
    this.id,
    this.storyId,
    this.storyName,
    this.chapterId,
    this.chapterName,
    this.chapterNo,
    this.title,
    this.time,
    this.shortDiscription,
    this.activityImage,
    this.image,
    this.audio,
    this.documentEnglish,
    this.documentJapanese,
    this.characterName,
    this.endImage,
    this.createdAt,
    this.updatedAt,
    this.details,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    storyId: json["story_id"],
    storyName: json["story_name"],
    chapterId: json["chapter_id"],
    chapterName: json["chapter_name"],
    chapterNo: json["chapter_no"],
    title: json["title"],
    time: json["time"],
    shortDiscription: json["short_discription"],
    activityImage: json["activity_image"],
    image: json["image"],
    audio: json["audio"],
    documentEnglish: json["document_english"],
    documentJapanese: json["document_japanese"],
    characterName: json["character_name"],
    endImage: json["end_image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_id": storyId,
    "story_name": storyName,
    "chapter_id": chapterId,
    "chapter_name": chapterName,
    "chapter_no": chapterNo,
    "title": title,
    "time": time,
    "short_discription": shortDiscription,
    "activity_image": activityImage,
    "image": image,
    "audio": audio,
    "document_english": documentEnglish,
    "document_japanese": documentJapanese,
    "character_name": characterName,
    "end_image": endImage,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  int? id;
  String? activityId;
  String? srNo;
  String? question;
  List<String>? options;
  String? explation;
  dynamic image;
  String? correctAnswer;
  DateTime? createdAt;
  DateTime? updatedAt;

  Detail({
    this.id,
    this.activityId,
    this.srNo,
    this.question,
    this.options,
    this.explation,
    this.image,
    this.correctAnswer,
    this.createdAt,
    this.updatedAt,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    activityId: json["activity_id"],
    srNo: json["sr_no"],
    question: json["question"],
    options: json["options"] == null ? [] : List<String>.from(json["options"]!.map((x) => x)),
    explation: json["explation"],
    image: json["image"],
    correctAnswer: json["correct_answer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "activity_id": activityId,
    "sr_no": srNo,
    "question": question,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
    "explation": explation,
    "image": image,
    "correct_answer": correctAnswer,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
