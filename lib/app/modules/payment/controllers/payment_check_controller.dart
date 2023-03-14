import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/booking_provider.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/response/booking_response.dart';

class PaymentCheckController extends GetxController {
  // PROVIDER
  final BookingProvider bookingProvider = BookingProvider(ApiClient.init());

  // OBSERVABLE
  final booking = BookingData().obs;

  // FUNCTION
  Future<void> getBookingByID() async {
    final res = await bookingProvider.getBookingByID(
      Get.arguments['booking_id'],
    );

    if (res != null) {
      booking.update((val) {
        val!.createdAt = res.createdAt;
        val.isPaid = res.isPaid;
        val.paymentType = res.paymentType;
        val.total = res.total;
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    await getBookingByID();

    super.onReady();
  }

  @override
  void onClose() {}
}
