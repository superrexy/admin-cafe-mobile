import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/login_request.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class LoginController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        final res = await _authenticationProvider.login(
          LoginRequest(
            email: emailController.text,
            password: passwordController.text,
          ),
        );

        if (res != null) {
          Storage.saveValue(Constants.token, res.data.token);
          Get.offAllNamed(Routes.DASHBOARD);
          Get.snackbar("Success", "Berhasil Login",
              backgroundColor: Colors.green, colorText: Colors.white);
        }
      } catch (e) {
        if (e == "USER_NOT_FOUND") {
          Get.snackbar("Terdapat Kesalahan", "User Tidak Ditemukan",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else if (e == "WRONG_PASSWORD") {
          Get.snackbar("Terdapat Kesalahan", "Password Salah",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.snackbar("Terdapat Kesalahan", "Something went wrong",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    }
  }
}
