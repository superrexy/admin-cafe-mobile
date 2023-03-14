import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 43.0, vertical: 14.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.chevron_left_outlined)),
                  )),
                  Expanded(
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'Lupa Password',
                          style: AppTextStyle.boldStyle.copyWith(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Form(
                  key: controller.resetPasswordFormKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImages.imgForgotPassword,
                        fit: BoxFit.cover,
                        width: 120,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Masukkan Email Yang Terdaftar',
                        style: AppTextStyle.mediumStyle.copyWith(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FormInputField(
                        controller: controller.emailController,
                        hintText: 'Masukkan Email Anda',
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Email tidak valid';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width,
                child: FormButton(
                  child: Text("Selanjutnya",
                      style: AppTextStyle.boldStyle
                          .copyWith(fontSize: 14, color: Colors.white)),
                  onPressed: () => controller.onSubmit(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
