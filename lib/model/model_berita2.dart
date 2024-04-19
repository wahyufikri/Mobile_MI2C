// To parse this JSON data, do
//
//     final modelBerita2 = modelBerita2FromJson(jsonString);

import 'dart:convert';

ModelBerita2 modelBerita2FromJson(String str) => ModelBerita2.fromJson(json.decode(str));

String modelBerita2ToJson(ModelBerita2 data) => json.encode(data.toJson());

class ModelBerita2 {
  bool isSuccess;
  String message;
  List<Datum> data;

  ModelBerita2({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelBerita2.fromJson(Map<String, dynamic> json) => ModelBerita2(
    isSuccess: json["isSuccess"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String judul;
  String berita;
  String gambar;

  Datum({
    required this.id,
    required this.judul,
    required this.berita,
    required this.gambar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    judul: json["judul"],
    berita: json["berita"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "judul": judul,
    "berita": berita,
    "gambar": gambar,
  };
}
