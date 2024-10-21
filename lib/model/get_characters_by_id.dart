// To parse this JSON data, do
//
//     final getAllCharactersById = getAllCharactersByIdFromJson(jsonString);

import 'dart:convert';

GetAllCharactersById getAllCharactersByIdFromJson(String str) => GetAllCharactersById.fromJson(json.decode(str));

String getAllCharactersByIdToJson(GetAllCharactersById data) => json.encode(data.toJson());

class GetAllCharactersById {
  String? status;
  String? message;
  Data? data;

  GetAllCharactersById({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllCharactersById.fromJson(Map<String, dynamic> json) => GetAllCharactersById(
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
  String? name;
  String? storiesId;
  String? link;
  String? introducation;
  dynamic characterImage;
  String? requirements;
  dynamic prompt;
  List<String>? tags;
  String? storyName;

  Data({
    this.id,
    this.name,
    this.storiesId,
    this.link,
    this.introducation,
    this.characterImage,
    this.requirements,
    this.prompt,
    this.tags,
    this.storyName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    storiesId: json["stories_id"],
    link: json["link"],
    introducation: json["introducation"],
    characterImage: json["character_image"],
    requirements: json["requirements"],
    prompt: json["prompt"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    storyName: json["story_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "stories_id": storiesId,
    "link": link,
    "introducation": introducation,
    "character_image": characterImage,
    "requirements": requirements,
    "prompt": prompt,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "story_name": storyName,
  };
}
