import 'dart:convert';

// ignore_for_file: unnecessary_null_in_if_null_operators

LoginRegisterResponse loginRegisterResponseFromJson(String str) =>
    LoginRegisterResponse.fromJson(json.decode(str));

String loginRegisterResponseToJson(LoginRegisterResponse data) =>
    json.encode(data.toJson());

class LoginRegisterResponse {
  LoginRegisterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) =>
      LoginRegisterResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.address,
    this.imageProfile,
    this.birthDate,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String? phoneNumber;
  String? address;
  String? imageProfile;
  DateTime? birthDate;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"] ?? null,
        address: json["address"] ?? null,
        imageProfile: json["image_profile"] ?? null,
        birthDate: json["birth_date"] == null
            ? null
            : DateTime.parse(json["birth_date"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "image_profile": imageProfile,
        "birth_date": birthDate?.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
