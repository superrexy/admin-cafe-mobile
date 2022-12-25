import 'dart:convert';
import 'dart:io';

import 'package:admin_cafe_mobile/app/model/request/resetpassword_request.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:admin_cafe_mobile/app/model/request/login_request.dart';
import 'package:admin_cafe_mobile/app/model/request/profile_request.dart';
import 'package:admin_cafe_mobile/app/model/request/register_request.dart';
import 'package:admin_cafe_mobile/app/model/response/login_register_response.dart';
import 'package:admin_cafe_mobile/app/model/response/profile_response.dart';

class AuthenticationProvider {
  final Dio _client;

  AuthenticationProvider(this._client);

  Future<LoginRegisterResponse?> login(LoginRequest request) async {
    try {
      final Response response = await _client.post(
        '/auth/login',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return LoginRegisterResponse.fromJson(response.data);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<LoginRegisterResponse?> register(RegisterRequest request) async {
    try {
      final Response response = await _client.post(
        '/auth/register',
        data: request.toJson(),
      );

      if (response.statusCode == 201) {
        return LoginRegisterResponse.fromJson(response.data);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> uploadImageProfile(File image) async {
    try {
      final fileName = image.path.split('/').last;
      final extFile = fileName.split('.').last;

      FormData data = FormData.fromMap({
        "image": MultipartFile.fromBytes(
          image.readAsBytesSync(),
          filename: fileName,
          contentType: MediaType('image', extFile),
          headers: {
            'Content-Type': ['image/jpeg', 'image/png', 'image/jpg'],
          },
        ),
      });

      final Response response = await _client.post(
        '/auth/image-update',
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

  Future<ProfileResponse?> profileUser() async {
    try {
      final Response response = await _client.get(
        '/auth/profile',
      );

      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.data);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> updateProfileUser(ProfileRequest request) async {
    try {
      final Response response = await _client.post(
        '/auth/profile/update',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> requestPasswordReset(String email) async {
    try {
      final Map<String, dynamic> data = {
        'email': email,
      };

      final Response response = await _client.post(
        '/auth/reset-password/request',
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

  Future<bool> resetPassword(ResetPasswordRequest request) async {
    try {
      final Response response = await _client.post(
        '/auth/reset-password',
        data: request.toJson(),
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
