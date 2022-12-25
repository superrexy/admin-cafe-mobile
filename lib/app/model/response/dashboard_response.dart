import 'dart:convert';

DashboardResponse dashboardResponseFromJson(String str) =>
    DashboardResponse.fromJson(json.decode(str));

String dashboardResponseToJson(DashboardResponse data) =>
    json.encode(data.toJson());

class DashboardResponse {
  DashboardResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  DashboardData data;

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      DashboardResponse(
        status: json["status"],
        message: json["message"],
        data: DashboardData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DashboardData {
  DashboardData({
    required this.pegawaiCount,
    required this.roomCount,
    required this.bookingCount,
  });

  int pegawaiCount;
  int roomCount;
  int bookingCount;

  factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        pegawaiCount: json["pegawai_count"],
        roomCount: json["room_count"],
        bookingCount: json["booking_count"],
      );

  Map<String, dynamic> toJson() => {
        "pegawai_count": pegawaiCount,
        "room_count": roomCount,
        "booking_count": bookingCount,
      };
}
