import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/profile_request.dart';
import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';

class ProfileController extends GetxController {
  // Dashboard Controller
  final DashboardController dashboardController = Get.find();

  // API SERVICE
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());

  // Form
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void initTextController() {
    firstNameController.text = dashboardController.userProfile.value.firstName;
    lastNameController.text = dashboardController.userProfile.value.lastName;
    phoneController.text =
        dashboardController.userProfile.value.phoneNumber ?? "";
    addressController.text =
        dashboardController.userProfile.value.address ?? "";
  }

  Future<void> updateProfile() async {
    try {
      final res =
          await _authenticationProvider.updateProfileUser(ProfileRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text == "" ? null : phoneController.text,
        address: addressController.text == "" ? null : addressController.text,
      ));

      if (res) {
        Get.snackbar(
          "Berhasil",
          "Berhasil mengubah data",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        dashboardController.getProfileUser();
      }
    } catch (e) {
      Get.printError(info: e.toString());
      Get.snackbar(
        "Terdapat Kesalahan",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    initTextController();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
