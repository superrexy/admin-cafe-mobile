import 'dart:convert';

// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

BookingResponse bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) =>
    json.encode(data.toJson());

class BookingResponse {
  BookingResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<BookingData>? data;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<BookingData>.from(
                json["data"]!.map((x) => BookingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BookingData {
  BookingData({
    this.id,
    this.namaPemesan,
    this.emailPemesan,
    this.tglPemesanan,
    this.total,
    this.isFinished,
    this.roomId,
    this.userId,
    this.isPaid,
    this.transactionId,
    this.paymentType,
    this.createdAt,
    this.updatedAt,
    this.bookingFood,
    this.room,
    this.paymentUrl,
  });

  int? id;
  String? namaPemesan;
  String? emailPemesan;
  DateTime? tglPemesanan;
  int? total;
  bool? isFinished;
  int? roomId;
  int? userId;
  String? isPaid;
  String? transactionId;
  String? paymentType;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<BookingFood>? bookingFood;
  Room? room;
  String? paymentUrl;

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        id: json["id"],
        namaPemesan: json["nama_pemesan"],
        emailPemesan: json["email_pemesan"],
        tglPemesanan: json["tgl_pemesanan"] == null
            ? null
            : DateTime.parse(json["tgl_pemesanan"]),
        total: json["total"],
        isFinished: json["is_finished"],
        roomId: json["room_id"],
        userId: json["user_id"],
        isPaid: json["is_paid"],
        transactionId: json["transaction_id"],
        paymentType: json["payment_type"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        bookingFood: json["booking_food"] == null
            ? []
            : List<BookingFood>.from(
                json["booking_food"]!.map((x) => BookingFood.fromJson(x))),
        room: json["room"] == null ? null : Room.fromJson(json["room"]),
        // ignore: prefer_if_null_operators
        paymentUrl: json["payment_url"] == null ? null : json["payment_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pemesan": namaPemesan,
        "email_pemesan": emailPemesan,
        "tgl_pemesanan": tglPemesanan?.toIso8601String(),
        "total": total,
        "is_finished": isFinished,
        "room_id": roomId,
        "user_id": userId,
        "is_paid": isPaid,
        "transaction_id": transactionId,
        "payment_type": paymentType,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "booking_food": bookingFood == null
            ? []
            : List<dynamic>.from(bookingFood!.map((x) => x.toJson())),
        "room": room?.toJson(),
        "payment_url": paymentUrl,
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
        foodDrink: json["food_drink"] == null
            ? null
            : FoodDrink.fromJson(json["food_drink"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "food_drink_id": foodDrinkId,
        "amount": amount,
        "note": note,
        "total": total,
        "food_drink": foodDrink?.toJson(),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
    this.quota,
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
  int? quota;
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
        quota: json["quota"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "fasilitas": fasilitas,
        "kapasitas": kapasitas,
        "waktu": waktu,
        "harga": harga,
        "image": image,
        "quota": quota,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
