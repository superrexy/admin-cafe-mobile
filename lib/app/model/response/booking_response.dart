import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) =>
    json.encode(data.toJson());

class BookingResponse {
  BookingResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<BookingData> data;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        status: json["status"],
        message: json["message"],
        data: List<BookingData>.from(
            json["data"].map((x) => BookingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BookingData {
  BookingData({
    required this.id,
    required this.namaPemesan,
    required this.emailPemesan,
    required this.tglPemesanan,
    required this.total,
    required this.isPaid,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingFood,
    required this.room,
  });

  int id;
  String namaPemesan;
  String emailPemesan;
  DateTime tglPemesanan;
  int total;
  bool isPaid;
  int roomId;
  DateTime createdAt;
  DateTime updatedAt;
  List<BookingFood> bookingFood;
  Room room;

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        id: json["id"],
        namaPemesan: json["nama_pemesan"],
        emailPemesan: json["email_pemesan"],
        tglPemesanan: DateTime.parse(json["tgl_pemesanan"]),
        total: json["total"],
        isPaid: json["is_paid"],
        roomId: json["room_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        bookingFood: List<BookingFood>.from(
            json["booking_food"].map((x) => BookingFood.fromJson(x))),
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pemesan": namaPemesan,
        "email_pemesan": emailPemesan,
        "tgl_pemesanan": tglPemesanan.toIso8601String(),
        "total": total,
        "is_paid": isPaid,
        "room_id": roomId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "booking_food": List<dynamic>.from(bookingFood.map((x) => x.toJson())),
        "room": room.toJson(),
      };
}

class BookingFood {
  BookingFood({
    required this.bookingId,
    required this.foodDrinkId,
    required this.amount,
    required this.total,
    this.note,
    required this.foodDrink,
  });

  int bookingId;
  int foodDrinkId;
  int amount;
  int total;
  String? note;
  FoodDrink foodDrink;

  factory BookingFood.fromJson(Map<String, dynamic> json) => BookingFood(
        bookingId: json["booking_id"],
        foodDrinkId: json["food_drink_id"],
        amount: json["amount"],
        total: json["total"],
        note: json["note"],
        foodDrink: FoodDrink.fromJson(json["food_drink"]),
      );

  Map<String, dynamic> toJson() => {
        "booking_id": bookingId,
        "food_drink_id": foodDrinkId,
        "amount": amount,
        "total": total,
        "note": note,
        "food_drink": foodDrink.toJson(),
      };
}

class FoodDrink {
  FoodDrink({
    required this.id,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String nama;
  int harga;
  String deskripsi;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Room {
  Room({
    required this.id,
    required this.nama,
    required this.fasilitas,
    required this.kapasitas,
    required this.waktu,
    required this.harga,
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
  String image;
  DateTime createdAt;
  DateTime updatedAt;

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
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
