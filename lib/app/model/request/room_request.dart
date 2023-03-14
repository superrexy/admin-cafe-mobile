import 'dart:convert';
import 'dart:io';

RoomRequest roomRequestFromJson(String str) =>
    RoomRequest.fromJson(json.decode(str));

String roomRequestToJson(RoomRequest data) => json.encode(data.toJson());

class RoomRequest {
  RoomRequest({
    required this.nama,
    required this.fasilitas,
    required this.kapasitas,
    required this.waktu,
    required this.harga,
    required this.quota,
    this.image,
  });

  String nama;
  String fasilitas;
  String kapasitas;
  String waktu;
  String harga;
  String quota;
  File? image;

  factory RoomRequest.fromJson(Map<String, dynamic> json) => RoomRequest(
        nama: json["nama"],
        fasilitas: json["fasilitas"],
        kapasitas: json["kapasitas"],
        waktu: json["waktu"],
        harga: json["harga"],
        quota: json["quota"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "fasilitas": fasilitas,
        "kapasitas": kapasitas,
        "waktu": waktu,
        "harga": harga,
        "quota": quota,
      };
}
