import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/reset_password/controllers/verify_token_password_reset_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class VerifyTokenPasswordResetView
    extends GetView<VerifyTokenPasswordResetController> {
  const VerifyTokenPasswordResetView({Key? key}) : super(key: key);
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
                          'Verifikasi Token',
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
                  key: controller.tokenVerifyFormKey,
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
                        'Masukkan 6 digit kode yang telah kami kirimkan ke email anda',
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
                        controller: controller.tokenController,
                        hintText: 'Masukkan Token Anda',
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Token tidak boleh kosong';
                          } else if (!GetUtils.isLengthGreaterOrEqual(
                              value, 6)) {
                            return "Token harus 6 digit";
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
