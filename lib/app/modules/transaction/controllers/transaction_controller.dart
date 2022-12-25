import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/booking_provider.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/booking_request.dart';
import 'package:admin_cafe_mobile/app/model/response/booking_response.dart';
import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';

class TransactionController extends GetxController {
  // API CLIENT
  final BookingProvider _bookingProvider = BookingProvider(ApiClient.init());

  // DASHBOARD CONTROLLER
  final DashboardController dashboardController = Get.find();

  // OBSERVABLE
  final bookingsData = <BookingData>[].obs;

  Future<void> getBookingsData() async {
    try {
      final response = await _bookingProvider.getBookings();
      if (response != null) {
        bookingsData.assignAll(response);
      } else {
        bookingsData.clear();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteBooking(int id) async {
    try {
      final response = await _bookingProvider.deleteBooking(id);
      if (response != null) {
        getBookingsData();
        dashboardController.getAllData();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> paidBooking(BookingData data, int id) async {
    try {
      BookingRequest input = BookingRequest(
        emailPemesan: data.emailPemesan,
        namaPemesan: data.namaPemesan,
        isPaid: true,
        tglPemesanan: data.tglPemesanan,
        roomId: data.roomId.toString(),
      );

      final response = await _bookingProvider.updateBooking(input, id);
      if (response != null) {
        getBookingsData();
        dashboardController.getAllData();
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
    getBookingsData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
