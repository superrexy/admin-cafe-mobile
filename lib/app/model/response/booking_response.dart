// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse? bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse? data) =>
    json.encode(data!.toJson());

class BookingResponse {
  BookingResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<BookingData?>? data;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BookingData?>.from(
                json["data"]!.map((x) => BookingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
      };
}

class BookingData {
  BookingData({
    this.id,
    this.namaPemesan,
    this.emailPemesan,
    this.tglPemesanan,
    this.total,
    this.isPaid,
    this.roomId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.bookingFood,
    this.room,
  });

  int? id;
  String? namaPemesan;
  String? emailPemesan;
  DateTime? tglPemesanan;
  int? total;
  bool? isPaid;
  int? roomId;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BookingFood?>? bookingFood;
  Room? room;

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        id: json["id"],
        namaPemesan: json["nama_pemesan"],
        emailPemesan: json["email_pemesan"],
        tglPemesanan: DateTime.parse(json["tgl_pemesanan"]),
        total: json["total"],
        isPaid: json["is_paid"],
        roomId: json["room_id"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingFood: json["booking_food"] == null
            ? []
            : List<BookingFood?>.from(
                json["booking_food"]!.map((x) => BookingFood.fromJson(x))),
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pemesan": namaPemesan,
        "email_pemesan": emailPemesan,
        "tgl_pemesanan": tglPemesanan?.toIso8601String(),
        "total": total,
        "is_paid": isPaid,
        "room_id": roomId,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "booking_food": bookingFood == null
            ? []
            : List<dynamic>.from(bookingFood!.map((x) => x!.toJson())),
        "room": room!.toJson(),
      };
}

class BookingFood {
  BookingFood({
    this.bookingId,
    this.foodDrinkId,
    this.amount,
    this.note,
    this.total,
    this.foodDrink,
  });

  int? bookingId;
  int? foodDrinkId;
  int? amount;
  dynamic note;
  int? total;
  FoodDrink? foodDrink;

  factory BookingFood.fromJson(Map<String, dynamic> json) => BookingFood(
        bookingId: json["booking_id"],
        foodDrinkId: json["food_drink_id"],
        amount: json["amount"],
        note: json["note"],
        total: json["total"],
        foodDrink: FoodDrink.fromJson(json["food_drink"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "food_drink_id": foodDrinkId,
        "amount": amount,
        "note": note,
        "total": total,
        "food_drink": foodDrink!.toJson(),
      };
}

class FoodDrink {
  FoodDrink({
    this.id,
    this.nama,
    this.harga,
    this.deskripsi,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama;
  int? harga;
  String? deskripsi;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory FoodDrink.fromJson(Map<String, dynamic> json) => FoodDrink(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "deskripsi": deskripsi,
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Room {
  Room({
    this.id,
    this.nama,
    this.fasilitas,
    this.kapasitas,
    this.waktu,
    this.harga,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? nama;
  String? fasilitas;
  String? kapasitas;
  String? waktu;
  int? harga;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        nama: json["nama"],
        fasilitas: json["fasilitas"],
        kapasitas: json["kapasitas"],
        waktu: json["waktu"],
        harga: json["harga"],
        image: json["image"],
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
        "image": image,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
