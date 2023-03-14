import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:admin_cafe_mobile/app/model/response/banner_response.dart';

import '../model/request/banner_request.dart';

class BannerProvider {
  final Dio _client;

  BannerProvider(this._client);

  Future<List<BannerData>?> getBanners() async {
    try {
      final Response response = await _client.get(
        '/banners',
      );

      if (response.statusCode == 200) {
        final responseJson = response.data['data'] as List;
        return responseJson.map((e) => BannerData.fromJson(e)).toList();
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<BannerData?> getBannerByID(int bannerId) async {
    try {
      final Response response = await _client.get(
        '/banners/$bannerId',
      );

      if (response.statusCode == 200) {
        final responseJson = response.data['data'];
        return BannerData.fromJson(responseJson);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> createBanner(BannerRequest request) async {
    try {
      final fileName = request.image!.path.split('/').last;
      final extFile = fileName.split('.').last;

      FormData data = FormData.fromMap({
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
        '/banners/create',
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

  Future<bool> updateBanner(int bannerId, BannerRequest request) async {
    try {
      final fileName = request.image!.path.split('/').last;
      final extFile = fileName.split('.').last;

      FormData data = FormData.fromMap({
        "image": MultipartFile.fromBytes(
          request.image!.readAsBytesSync(),
          filename: fileName,
          contentType: MediaType('image', extFile),
          headers: {
            'Content-Type': ['image/jpeg', 'image/png', 'image/jpg'],
          },
        ),
      });

      final Response response = await _client.put(
        '/banners/$bannerId/update',
        data: data,
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> deleteBanner(int bannerId) async {
    try {
      final Response response = await _client.delete(
        '/banners/$bannerId/delete',
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
