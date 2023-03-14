import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class ApiClient {
  static Dio init() {
    final Dio dio = Dio();

    dio.options.baseUrl = Constants.baseUrlAPI;
    dio.options.connectTimeout = const Duration(seconds: 12);
    dio.options.receiveTimeout = const Duration(seconds: 12);
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 100,
    ));
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Get.closeAllSnackbars();
    EasyLoading.show(status: 'Loading ...');

    // Token
    final token = Storage.getValue(Constants.token);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    EasyLoading.dismiss();

    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    if (response.statusCode == 401) {
      Get.snackbar(
        'Sesi Token Habis !',
        'Silahkan login kembali',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      Get.offAllNamed(Routes.LOGIN);
    }

    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();

    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
