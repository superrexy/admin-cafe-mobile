import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/register_request.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final isPasswordVisible = false.obs;

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
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
  }

  void register() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        final res = await _authenticationProvider.register(
          RegisterRequest(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            password: passwordController.text,
            phoneNumber: phoneNumberController.text,
            address: addressController.text,
          ),
        );

        if (res != null) {
          Storage.saveValue(Constants.token, res.data!.token);
          Get.offAllNamed(Routes.IMAGE_PROFILE);
        }
      } catch (e) {
        Get.printError(info: e.toString());
        Get.snackbar(
          "Terdapat Kesalahan",
          "Something went wrong",
        );
      }
    }
  }
}
