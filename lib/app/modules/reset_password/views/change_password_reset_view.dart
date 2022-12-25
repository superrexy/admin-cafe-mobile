import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/reset_password/controllers/change_password_reset_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordResetView extends GetView<ChangePasswordResetController> {
  const ChangePasswordResetView({Key? key}) : super(key: key);
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
                    flex: 2,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'Ganti Password Baru',
                          style: AppTextStyle.boldStyle.copyWith(
                            fontSize: 16,
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
                  key: controller.changePasswordFormKey,
                  child: Column(
                    children: [
                      const FormLabel(label: "Password Baru"),
                      FormInputField(
                        controller: controller.passwordController,
                        hintText: 'Masukkan Password Baru Anda',
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Kata Sandi tidak boleh kosong !";
                          } else if (!GetUtils.isLengthGreaterOrEqual(
                              value, 8)) {
                            return "Kata Sandi minimal 8 karakter !";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const FormLabel(label: "Password Baru Konfirmasi"),
                      FormInputField(
                        controller: controller.confirmPasswordController,
                        hintText: 'Masukkan Password Baru Konfirmasi Anda',
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Kata Sandi Konfirmasi tidak boleh kosong !";
                          } else if (!GetUtils.isLengthGreaterOrEqual(
                              value, 8)) {
                            return "Kata Sandi Konfirmasi minimal 8 karakter !";
                          } else if (controller.passwordController.text !=
                              controller.confirmPasswordController.text) {
                            return "Kata Sandi Konfirmasi tidak sama !";
                          } else {
                            return null;
                          }
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
