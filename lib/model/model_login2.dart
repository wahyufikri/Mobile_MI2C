// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  int value;
  String message;
  String nama;
  String username;
  String id;

  ModelLogin({
    required this.value,
    required this.message,
    required this.nama,
    required this.username,
    required this.id,
  });

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
    value: json["value"],
    message: json["message"],
    nama: json["nama"],
    username: json["username"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "message": message,
    "nama": nama,
    "username": username,
    "id":id,
  };
}
