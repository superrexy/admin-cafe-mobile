import 'package:dio/dio.dart';

import 'package:admin_cafe_mobile/app/model/response/dashboard_response.dart';

class DashboardProvider {
  final Dio _client;

  DashboardProvider(this._client);

  Future<DashboardResponse?> getDashboard() async {
    try {
      final Response response = await _client.get('/dashboard');
      if (response.statusCode == 200) {
        return DashboardResponse.fromJson(response.data);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }
}
