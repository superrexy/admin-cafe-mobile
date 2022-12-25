import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) =>
    ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) =>
    json.encode(data.toJson());

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.email,
    this.token,
    this.password,
    this.isVerify,
  });

  String? email;
  String? token;
  String? password;
  bool? isVerify;

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      ResetPasswordRequest(
        email: json["email"],
        token: json["token"],
        password: json["password"],
        isVerify: json["is_verify"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "token": token,
        "password": password,
        "is_verify": isVerify,
      };
}
