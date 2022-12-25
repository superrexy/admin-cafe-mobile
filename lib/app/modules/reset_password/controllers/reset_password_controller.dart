import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  // API CliENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());
  // FORM
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  Future<void> onSubmit() async {
    if (resetPasswordFormKey.currentState!.validate()) {
      try {
        final res = await _authenticationProvider.requestPasswordReset(
          emailController.text,
        );

        if (res) {
          Get.snackbar(
            'Berhasil',
            'Silahkan cek email anda untuk melakukan reset password',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          Get.toNamed(Routes.RESET_PASSWORD_VERIFY);
        }
      } catch (e) {
        Get.printError(info: e.toString());
        if (e == "USER_NOT_FOUND") {
          Get.snackbar("Terdapat Kesalahan", "Email tidak terdaftar",
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
