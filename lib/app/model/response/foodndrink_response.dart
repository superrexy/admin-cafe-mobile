import 'dart:convert';

import 'package:admin_cafe_mobile/app/common/constants.dart';

FoodnDrinkResponse foodnDrinkResponseFromJson(String str) =>
    FoodnDrinkResponse.fromJson(json.decode(str));

String foodnDrinkResponseToJson(FoodnDrinkResponse data) =>
    json.encode(data.toJson());

class FoodnDrinkResponse {
  FoodnDrinkResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<FoodnDrinkData> data;

  factory FoodnDrinkResponse.fromJson(Map<String, dynamic> json) =>
      FoodnDrinkResponse(
        status: json["status"],
        message: json["message"],
        data: List<FoodnDrinkData>.from(
            json["data"].map((x) => FoodnDrinkData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FoodnDrinkData {
  FoodnDrinkData({
    required this.id,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.quantity = 1,
    this.isChecked = false,
    this.note,
  });

  int id;
  String nama;
  int harga;
  String deskripsi;
  String image;
  int? quantity;
  bool? isChecked;
  String? note;
  DateTime createdAt;
  DateTime updatedAt;

  factory FoodnDrinkData.fromJson(Map<String, dynamic> json) => FoodnDrinkData(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        image: Constants.baseUrlImage + json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "deskripsi": deskripsi,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
