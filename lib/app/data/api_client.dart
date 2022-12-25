import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';

class ApiClient {
  static Dio init() {
    final Dio dio = Dio();

    dio.options.baseUrl = Constants.baseUrl;
    dio.options.connectTimeout = 8000;
    dio.options.receiveTimeout = 8000;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.interceptors.add(ApiInterceptors());
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    EasyLoading.show(status: 'Loading ...');

    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

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
