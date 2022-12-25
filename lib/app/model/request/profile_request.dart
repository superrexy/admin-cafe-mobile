import 'dart:convert';

ProfileRequest profileRequestFromJson(String str) =>
    ProfileRequest.fromJson(json.decode(str));

String profileRequestToJson(ProfileRequest data) => json.encode(data.toJson());

class ProfileRequest {
  ProfileRequest({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.birthDate,
  });

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? birthDate;

  factory ProfileRequest.fromJson(Map<String, dynamic> json) => ProfileRequest(
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        birthDate: json["birth_date"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "address": address,
        "birth_date": birthDate,
      };
}
