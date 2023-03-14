import 'dart:convert';

import 'package:admin_cafe_mobile/app/common/constants.dart';

RoomResponse roomResponseFromJson(String str) =>
    RoomResponse.fromJson(json.decode(str));

String roomResponseToJson(RoomResponse data) => json.encode(data.toJson());

class RoomResponse {
  RoomResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<RoomData> data;

  factory RoomResponse.fromJson(Map<String, dynamic> json) => RoomResponse(
        status: json["status"],
        message: json["message"],
        data:
            List<RoomData>.from(json["data"].map((x) => RoomData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class RoomData {
  RoomData({
    required this.id,
    required this.nama,
    required this.fasilitas,
    required this.kapasitas,
    required this.waktu,
    required this.harga,
    required this.quota,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  String fasilitas;
  String kapasitas;
  String waktu;
  int harga;
  int quota;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory RoomData.fromJson(Map<String, dynamic> json) => RoomData(
        id: json["id"],
        nama: json["nama"],
        fasilitas: json["fasilitas"],
        kapasitas: json["kapasitas"],
        waktu: json["waktu"],
        harga: json["harga"],
        quota: json["quota"],
        image: Constants.baseUrl + json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "fasilitas": fasilitas,
        "kapasitas": kapasitas,
        "waktu": waktu,
        "harga": harga,
        "quota": quota,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
