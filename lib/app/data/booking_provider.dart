import 'package:dio/dio.dart';

import 'package:admin_cafe_mobile/app/model/request/booking_request.dart';
import 'package:admin_cafe_mobile/app/model/response/booking_response.dart';

class BookingProvider {
  final Dio _client;
  BookingProvider(this._client);

  Future<List<BookingData>?> getBookings() async {
    try {
      final Response response = await _client.get('/bookings');
      if (response.statusCode == 200) {
        final jsonResponse = response.data['data'] as List;
        return jsonResponse.map((e) => BookingData.fromJson(e)).toList();
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<List<BookingData>?> getBookingsByDate(DateTime date) async {
    try {
      final Response response = await _client.get('/bookings?date=$date');
      if (response.statusCode == 200) {
        final jsonResponse = response.data['data'] as List;
        return jsonResponse.map((e) => BookingData.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<BookingData?> getBookingByID(int bookingId) async {
    try {
      final Response response = await _client.get('/bookings/$bookingId');
      if (response.statusCode == 200) {
        return BookingData.fromJson(response.data['data']);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<BookingData?> createBooking(BookingRequest request) async {
    try {
      final Response response =
          await _client.post('/bookings/create', data: request.toJson());
      if (response.statusCode == 201) {
        return BookingData.fromJson(response.data['data']);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<BookingData?> updateBooking(
      BookingRequest request, int bookingId) async {
    try {
      final Response response = await _client.put(
        '/bookings/$bookingId/update',
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return BookingData.fromJson(response.data['data']);
      }

      return null;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }

  Future<bool> deleteBooking(int bookingId) async {
    try {
      final Response response =
          await _client.delete('/bookings/$bookingId/delete');
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } on DioError catch (e) {
      throw e.response?.data['message'];
    }
  }
}
