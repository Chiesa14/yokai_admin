// To parse this JSON data, do
//
//     final getAllCharacters = getAllCharactersFromJson(jsonString);

import 'dart:convert';

GetAllCharacters getAllCharactersFromJson(String str) => GetAllCharacters.fromJson(json.decode(str));

String getAllCharactersToJson(GetAllCharacters data) => json.encode(data.toJson());

class GetAllCharacters {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllCharacters({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllCharacters.fromJson(Map<String, dynamic> json) => GetAllCharacters(
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
  String? storiesId;
  String? link;
  String? introducation;
  dynamic prompt;
  String? characterImage;
  String? requirements;
  List<String>? tags;
  String? storyName;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.name,
    this.storiesId,
    this.link,
    this.introducation,
    this.prompt,
    this.characterImage,
    this.requirements,
    this.tags,
    this.storyName,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    storiesId: json["stories_id"],
    link: json["link"],
    introducation: json["introducation"],
    prompt: json["prompt"],
    characterImage: json["character_image"],
    requirements: json["requirements"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    storyName: json["story_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "stories_id": storiesId,
    "link": link,
    "introducation": introducation,
    "prompt": prompt,
    "character_image": characterImage,
    "requirements": requirements,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "story_name": storyName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
