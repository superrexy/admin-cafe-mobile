import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/booking/controllers/booking_controller.dart';
import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';
import 'package:admin_cafe_mobile/app/modules/foodndrink/controllers/form_foodndrink_controller.dart';

import '../controllers/foodndrink_controller.dart';

class FoodndrinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormFoodndrinkController>(
      () => FormFoodndrinkController(),
    );
    Get.lazyPut<FoodndrinkController>(
      () => FoodndrinkController(),
    );
    Get.lazyPut<FormBookingController>(
      () => FormBookingController(),
    );
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
  }
}
