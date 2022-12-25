import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/booking/controllers/booking_controller.dart';
import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';
import 'package:admin_cafe_mobile/app/modules/room/controllers/form_room_controller.dart';

import '../controllers/room_controller.dart';

class RoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormRoomController>(
      () => FormRoomController(),
    );
    Get.lazyPut<RoomController>(
      () => RoomController(),
    );
    Get.lazyPut<FormBookingController>(
      () => FormBookingController(),
    );
    Get.lazyPut<BookingController>(
      () => BookingController(),
    );
  }
}
