import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:admin_cafe_mobile/app/model/request/foodndrink_request.dart';
import 'package:admin_cafe_mobile/app/model/response/foodndrink_response.dart';

class FoodnDrinkProvier {
  final Dio _client;
  FoodnDrinkProvier(this._client);

  Future<List<FoodnDrinkData>> getFoodsnDrinks() async {
    try {
      final Response response = await _client.get(
        '/foods-drinks',
      );

      if (response.statusCode == 200) {
        return (response.data['data'] as List)
            .map((e) => FoodnDrinkData.fromJson(e))
            .toList();
      }

      return [];
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<FoodnDrinkData?> getFoodnDrinkByID(int foodId) async {
    try {
      final Response response = await _client.get(
        '/foods-drinks/$foodId',
      );

      if (response.statusCode == 200) {
        return FoodnDrinkData.fromJson(response.data['data']);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> createFoodnDrink(FoodnDrinkRequest request) async {
    try {
      final fileName = request.image!.path.split('/').last;
      final extFile = fileName.split('.').last;

      FormData data = FormData.fromMap({
        "nama": request.nama,
        "harga": request.harga,
        "deskripsi": request.deskripsi,
        "image": MultipartFile.fromBytes(
          request.image!.readAsBytesSync(),
          filename: fileName,
          contentType: MediaType('image', extFile),
          headers: {
            'Content-Type': ['image/jpeg', 'image/png', 'image/jpg'],
          },
        ),
      });

      final response = await _client.post(
        '/foods-drinks/create',
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

  Future<bool> updateFoodnDrink(FoodnDrinkRequest request, int foodId) async {
    try {
      if (request.image != null) {
        final fileName = request.image!.path.split('/').last;
        final extFile = fileName.split('.').last;

        FormData data = FormData.fromMap({
          "nama": request.nama,
          "harga": request.harga,
          "deskripsi": request.deskripsi,
          "image": MultipartFile.fromBytes(
            request.image!.readAsBytesSync(),
            filename: fileName,
            contentType: MediaType('image', extFile),
            headers: {
              'Content-Type': ['image/jpeg', 'image/png', 'image/jpg'],
            },
          ),
        });

        final response = await _client.put(
          '/foods-drinks/$foodId/update',
          data: data,
        );

        if (response.statusCode == 200) {
          return true;
        }
      } else {
        final response = await _client.put(
          '/foods-drinks/$foodId/update',
          data: {
            "nama": request.nama,
            "harga": request.harga,
            "deskripsi": request.deskripsi,
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

  Future<bool> deleteFoodnDrink(int foodId) async {
    try {
      final response = await _client.delete(
        '/foods-drinks/$foodId/delete',
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
