import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';

import '../controllers/booking_controller.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormBookingController>(
      () => FormBookingController(),
    );
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
  }
}
