import 'dart:convert';

BookingRequest bookingRequestFromJson(String str) =>
    BookingRequest.fromJson(json.decode(str));

String bookingRequestToJson(BookingRequest data) => json.encode(data.toJson());

class BookingRequest {
  BookingRequest({
    required this.namaPemesan,
    required this.emailPemesan,
    required this.tglPemesanan,
    this.isPaid,
    required this.roomId,
    this.paymentType,
    this.foodsndrinks,
    this.mobileNumber,
  });

  String namaPemesan;
  String emailPemesan;
  DateTime tglPemesanan;
  bool? isPaid;
  String roomId;
  String? paymentType;
  List<Foodsndrink>? foodsndrinks;
  String? mobileNumber;

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
        namaPemesan: json["nama_pemesan"],
        emailPemesan: json["email_pemesan"],
        tglPemesanan: DateTime.parse(json["tgl_pemesanan"]),
        isPaid: json["is_paid"],
        roomId: json["room_id"],
        paymentType: json["payment_type"],
        foodsndrinks: List<Foodsndrink>.from(
            json["foodsndrinks"].map((x) => Foodsndrink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nama_pemesan": namaPemesan,
        "email_pemesan": emailPemesan,
        "tgl_pemesanan": tglPemesanan.toIso8601String(),
        "is_paid": isPaid,
        "room_id": roomId,
        "payment_type": paymentType,
        "mobile_number": mobileNumber,
        "foodsndrinks": foodsndrinks == null
            ? null
            : List<dynamic>.from(foodsndrinks!.map((x) => x.toJson())),
      };
}

class Foodsndrink {
  Foodsndrink({
    required this.foodDrinkId,
    required this.amount,
    this.note,
  });

  int foodDrinkId;
  int amount;
  String? note;

  factory Foodsndrink.fromJson(Map<String, dynamic> json) => Foodsndrink(
        foodDrinkId: json["food_drink_id"],
        amount: json["amount"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "food_drink_id": foodDrinkId,
        "amount": amount,
        "note": note,
      };
}
