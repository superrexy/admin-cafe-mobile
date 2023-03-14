import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/resetpassword_request.dart';
import 'package:admin_cafe_mobile/app/modules/reset_password/controllers/reset_password_controller.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class VerifyTokenPasswordResetController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());

  // RESET PASSWORD CONTROLLER
  final ResetPasswordController resetPasswordController =
      Get.find<ResetPasswordController>();
  // FORM
  final GlobalKey<FormState> tokenVerifyFormKey = GlobalKey<FormState>();
  final TextEditingController tokenController = TextEditingController();

  Future<void> onSubmit() async {
    if (tokenVerifyFormKey.currentState!.validate()) {
      try {
        final response = await _authenticationProvider.resetPassword(
          ResetPasswordRequest(
            email: resetPasswordController.emailController.text,
            token: tokenController.text,
            isVerify: true,
          ),
        );

        if (response) {
          Get.offNamed(Routes.CHANGE_PASSWORD_RESET, arguments: {
            'email': resetPasswordController.emailController.text,
            'token': tokenController.text,
          });
          Get.snackbar(
            'Berhasil',
            'Token valid, silahkan masukkan password baru',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.printError(info: e.toString());

        if (e == "USER_NOT_FOUND") {
          Get.snackbar("Terdapat Kesalahan", "Email tidak terdaftar",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else if (e == "TOKEN_NOT_FOUND") {
          Get.snackbar("Terdapat Kesalahan", "Token tidak terdaftar",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else if (e == "TOKEN_IS_INVALID") {
          Get.snackbar("Terdapat Kesalahan", "Token tidak valid",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else if (e == "TOKEN_IS_EXPIRED") {
          Get.back();
          Get.snackbar("Terdapat Kesalahan", "Token sudah kadaluarsa",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.snackbar("Terdapat Kesalahan", "Something went wrong",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    }
  }

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
    tokenController.dispose();
    super.onClose();
  }
}
