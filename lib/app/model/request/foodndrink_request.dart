import 'dart:convert';
import 'dart:io';

FoodnDrinkRequest foodnDrinkRequestFromJson(String str) =>
    FoodnDrinkRequest.fromJson(json.decode(str));

String foodnDrinkRequestToJson(FoodnDrinkRequest data) =>
    json.encode(data.toJson());

class FoodnDrinkRequest {
  FoodnDrinkRequest({
    required this.nama,
    required this.harga,
    required this.deskripsi,
    this.image,
  });

  String nama;
  String harga;
  String deskripsi;
  File? image;

  factory FoodnDrinkRequest.fromJson(Map<String, dynamic> json) =>
      FoodnDrinkRequest(
        nama: json["nama"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
        "deskripsi": deskripsi,
      };
}
