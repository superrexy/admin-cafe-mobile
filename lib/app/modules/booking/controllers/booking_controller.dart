import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/booking_provider.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/response/booking_response.dart';

class BookingController extends GetxController {
  // API CLIENT
  final BookingProvider _bookingProvider = BookingProvider(ApiClient.init());

  // Observable
  final bookingsData = <BookingData>[].obs;

  final orderItemSelected = "none".obs;
  var orderItems = [
    {
      "key": "Nama",
      "value": "none",
    },
    {
      "key": "Ascending",
      "value": "asc",
    },
    {
      "key": "Descending",
      "value": "desc",
    },
  ];

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

  @override
  void onInit() {
    getBookingsData();
    super.onInit();
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
