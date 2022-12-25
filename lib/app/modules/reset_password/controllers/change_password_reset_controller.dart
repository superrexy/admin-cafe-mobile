import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/resetpassword_request.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordResetController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());

  // FORM
  final GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> onSubmit() async {
    if (changePasswordFormKey.currentState!.validate()) {
      try {
        final response = await _authenticationProvider.resetPassword(
          ResetPasswordRequest(
            email: Get.arguments['email'],
            token: Get.arguments['token'],
            isVerify: false,
            password: passwordController.text,
          ),
        );

        if (response) {
          Get.offAllNamed(Routes.LOGIN);
          Get.snackbar(
            'Berhasil',
            'Silahkan Login Kembali, Password telah diubah',
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
    super.onClose();
  }
}
