import 'dart:convert';

// To parse this JSON data, do
//
//     final loginRegisterResponse = loginRegisterResponseFromJson(jsonString);

LoginRegisterResponse? loginRegisterResponseFromJson(String str) =>
    LoginRegisterResponse.fromJson(json.decode(str));

String loginRegisterResponseToJson(LoginRegisterResponse? data) =>
    json.encode(data!.toJson());

class LoginRegisterResponse {
  LoginRegisterResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) =>
      LoginRegisterResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "token": token,
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.address,
    this.imageProfile,
    this.birthDate,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? firstName;
  dynamic lastName;
  String? email;
  dynamic phoneNumber;
  dynamic address;
  dynamic imageProfile;
  dynamic birthDate;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        imageProfile: json["image_profile"],
        birthDate: json["birth_date"],
        role: json["role"],
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
        "birth_date": birthDate,
        "role": role,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
