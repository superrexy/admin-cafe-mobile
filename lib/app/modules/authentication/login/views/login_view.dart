import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 43.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.logo),
            const SizedBox(
              height: 23,
            ),
            Text(
              "Selamat Datang !",
              style: AppTextStyle.heading2.copyWith(
                fontSize: 15,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 13,
            ),
            Text(
              "Masuk Ke Akun Anda",
              style: AppTextStyle.heading1.copyWith(fontSize: 24),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormLabel(
                    label: "Email",
                    isRequired: true,
                  ),
                  FormInputField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                    hintText: 'Masukkan Email Anda !',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Email tidak boleh kosong !";
                      } else if (!GetUtils.isEmail(val)) {
                        return "Email tidak valid !";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const FormLabel(
                    label: "Kata Sandi",
                    isRequired: true,
                  ),
                  Obx(
                    () => FormInputField(
                      controller: controller.passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      hintText: 'Masukkan Kata Sandi Anda !',
                      suffixIcon: IconButton(
                        onPressed: () => controller.isPasswordVisible.value =
                            !controller.isPasswordVisible.value,
                        icon: !controller.isPasswordVisible.value
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      obscureText: !controller.isPasswordVisible.value,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Kata Sandi tidak boleh kosong !";
                        } else if (!GetUtils.isLengthGreaterOrEqual(val, 8)) {
                          return "Kata Sandi minimal 8 karakter !";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: FormButton(
                      child: const Text("Masuk"),
                      onPressed: () => controller.login(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: Get.width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.RESET_PASSWORD),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Lupa Kata Sandi ?",
                        style: AppTextStyle.body.copyWith(
                            fontSize: 14.0, color: AppColors.kPrimaryGreen1),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Belum Punya Akun ?",
                          style: AppTextStyle.body
                              .copyWith(fontSize: 14.0, color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed(Routes.REGISTER),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "Daftar",
                            style: AppTextStyle.body.copyWith(
                                fontSize: 14.0,
                                color: AppColors.kPrimaryGreen1),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
