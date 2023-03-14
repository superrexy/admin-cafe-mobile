import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:admin_cafe_mobile/app/model/request/room_request.dart';
import 'package:admin_cafe_mobile/app/model/response/room_response.dart';

class RoomProvider {
  final Dio _client;

  RoomProvider(this._client);

  Future<List<RoomData>> getRooms() async {
    try {
      final Response response = await _client.get(
        '/rooms',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => RoomData.fromJson(e))
            .toList();
      }

      return [];
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<RoomData?> getRoom(int roomId) async {
    try {
      final Response response = await _client.get(
        '/rooms/$roomId',
      );

      if (response.statusCode == 200) {
        return RoomData.fromJson(response.data['data']);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> createRoom(RoomRequest request) async {
    try {
      final fileName = request.image!.path.split('/').last;
      final extFile = fileName.split('.').last;
      FormData data = FormData.fromMap({
        "nama": request.nama,
        "fasilitas": request.fasilitas,
        "kapasitas": request.kapasitas,
        "waktu": request.waktu,
        "harga": request.harga,
        "quota": request.quota,
        "image": MultipartFile.fromBytes(
          request.image!.readAsBytesSync(),
          filename: fileName,
          contentType: MediaType('image', extFile),
          headers: {
            'Content-Type': ['image/jpeg', 'image/png', 'image/jpg'],
          },
        ),
      });

      final Response response = await _client.post(
        '/rooms/create',
        data: data,
      );

      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> updateRoom(RoomRequest request, int roomId) async {
    try {
      if (request.image != null) {
        final fileName = request.image!.path.split('/').last;
        final extFile = fileName.split('.').last;
        FormData data = FormData.fromMap({
          "nama": request.nama,
          "fasilitas": request.fasilitas,
          "kapasitas": request.kapasitas,
          "waktu": request.waktu,
          "harga": request.harga,
          "quota": request.quota,
          "image": MultipartFile.fromFile(
            request.image!.path,
            filename: fileName,
            contentType: MediaType('image', extFile),
            headers: {
              'Content-Type': ['image/jpeg', 'image/png', 'image/jpg'],
            },
          ),
        });

        final Response response = await _client.put(
          '/rooms/$roomId/update',
          data: data,
        );

        if (response.statusCode == 200) {
          return true;
        }
      } else {
        final Response response = await _client.put(
          '/rooms/$roomId/update',
          data: {
            "nama": request.nama,
            "fasilitas": request.fasilitas,
            "kapasitas": request.kapasitas,
            "waktu": request.waktu,
            "harga": request.harga,
            "quota": request.quota,
          },
        );

        if (response.statusCode == 200) {
          return true;
        }
      }

      return false;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> deleteRoom(int roomId) async {
    try {
      final Response response = await _client.delete(
        '/rooms/$roomId/delete',
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }
}
