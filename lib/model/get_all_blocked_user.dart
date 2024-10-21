// To parse this JSON data, do
//
//     final getAllBlockedUser = getAllBlockedUserFromJson(jsonString);

import 'dart:convert';

GetAllBlockedUser getAllBlockedUserFromJson(String str) => GetAllBlockedUser.fromJson(json.decode(str));

String getAllBlockedUserToJson(GetAllBlockedUser data) => json.encode(data.toJson());

class GetAllBlockedUser {
  String? status;
  String? message;
  List<Datum>? data;

  GetAllBlockedUser({
    this.status,
    this.message,
    this.data,
  });

  factory GetAllBlockedUser.fromJson(Map<String, dynamic> json) => GetAllBlockedUser(
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
  String? accountStatus;
  DateTime? updatedAt;
  DateTime? expireSessionToken;
  int? id;
  String? email;
  String? password;
  String? name;
  String? phoneNumber;
  DateTime? createdAt;
  String? sessionToken;
  DateTime? lastSessionTime;

  Datum({
    this.accountStatus,
    this.updatedAt,
    this.expireSessionToken,
    this.id,
    this.email,
    this.password,
    this.name,
    this.phoneNumber,
    this.createdAt,
    this.sessionToken,
    this.lastSessionTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    accountStatus: json["account_status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    expireSessionToken: json["expire_session_token"] == null ? null : DateTime.parse(json["expire_session_token"]),
    id: json["id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    phoneNumber: json["phone_number"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    sessionToken: json["session_token"],
    lastSessionTime: json["last_session_time"] == null ? null : DateTime.parse(json["last_session_time"]),
  );

  Map<String, dynamic> toJson() => {
    "account_status": accountStatus,
    "updated_at": updatedAt?.toIso8601String(),
    "expire_session_token": expireSessionToken?.toIso8601String(),
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "phone_number": phoneNumber,
    "created_at": createdAt?.toIso8601String(),
    "session_token": sessionToken,
    "last_session_time": lastSessionTime?.toIso8601String(),
  };
}
