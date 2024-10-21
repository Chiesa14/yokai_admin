// To parse this JSON data, do
//
//     final getAllUser = getAllUserFromJson(jsonString);

import 'dart:convert';

GetAllUser getAllUserFromJson(String str) => GetAllUser.fromJson(json.decode(str));

String getAllUserToJson(GetAllUser data) => json.encode(data.toJson());

class GetAllUser {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllUser({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllUser.fromJson(Map<String, dynamic> json) => GetAllUser(
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
  String? password;
  String? name;
  int? id;
  String? phoneNumber;
  DateTime? createdAt;
  String? sessionToken;
  DateTime? lastSessionTime;
  String? email;
  String? accountStatus;
  DateTime? updatedAt;
  DateTime? expireSessionToken;

  Datum({
    this.password,
    this.name,
    this.id,
    this.phoneNumber,
    this.createdAt,
    this.sessionToken,
    this.lastSessionTime,
    this.email,
    this.accountStatus,
    this.updatedAt,
    this.expireSessionToken,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    password: json["password"],
    name: json["name"],
    id: json["id"],
    phoneNumber: json["phone_number"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    sessionToken: json["session_token"],
    lastSessionTime: json["last_session_time"] == null ? null : DateTime.parse(json["last_session_time"]),
    email: json["email"],
    accountStatus: json["account_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    expireSessionToken: json["expire_session_token"] == null ? null : DateTime.parse(json["expire_session_token"]),
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "name": name,
    "id": id,
    "phone_number": phoneNumber,
    "created_at": createdAt?.toIso8601String(),
    "session_token": sessionToken,
    "last_session_time": lastSessionTime?.toIso8601String(),
    "email": email,
    "account_status": accountStatus,
    "updated_at": updatedAt?.toIso8601String(),
    "expire_session_token": expireSessionToken?.toIso8601String(),
  };
}
