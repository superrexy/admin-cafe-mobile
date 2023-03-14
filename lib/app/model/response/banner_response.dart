import 'dart:convert';

import 'package:admin_cafe_mobile/app/common/constants.dart';

BannerResponse bannerResponseFromJson(String str) =>
    BannerResponse.fromJson(json.decode(str));

String bannerResponseToJson(BannerResponse data) => json.encode(data.toJson());

class BannerResponse {
  BannerResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<BannerData> data;

  factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        status: json["status"],
        message: json["message"],
        data: List<BannerData>.from(
            json["data"].map((x) => BannerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class BannerData {
  BannerData({
    required this.id,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"],
        image: Constants.baseUrl + json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
