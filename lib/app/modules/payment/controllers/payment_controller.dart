import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Booking Controller
  final FormBookingController formBookingController =
      Get.find<FormBookingController>();

  final TextEditingController mobileNumberController = TextEditingController();
  final mobileNumberIsFilled = false.obs;
  final selectedBank = "".obs;

  @override
  void onInit() {
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
