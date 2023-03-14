import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 43.0),
          margin: EdgeInsets.only(top: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Buat Akun",
                style: AppTextStyle.heading2.copyWith(
                  fontSize: 28,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                "Ayo mulai hari ini!",
                style: AppTextStyle.regularStyle.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: controller.registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FormLabel(
                      label: "Nama Depan",
                      isRequired: true,
                    ),
                    FormInputField(
                      controller: controller.firstNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: 'Masukkan Nama Depan Anda !',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Nama Depan tidak boleh kosong !";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const FormLabel(
                      label: "Nama Belakang",
                      isRequired: true,
                    ),
                    FormInputField(
                      controller: controller.lastNameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hintText: 'Masukkan Nama Belakang Anda !',
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Nama Belakang tidak boleh kosong !";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    const FormLabel(label: "Nomer Telepon"),
                    FormInputField(
                      controller: controller.phoneNumberController,
                      keyboardType: TextInputType.phone,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      hintText: 'Masukkan Nomer Telepon Anda !',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const FormLabel(label: "Alamat"),
                    FormInputField(
                      controller: controller.addressController,
                      keyboardType: TextInputType.streetAddress,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.next,
                      hintText: 'Masukkan Alamat Anda !',
                      isTextArea: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: FormButton(
                          child: const Text("Daftar"),
                          onPressed: () => controller.register()),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.only(bottom: 32.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sudah Memiliki Akun ?",
                            style: AppTextStyle.body
                                .copyWith(fontSize: 14.0, color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              "Masuk",
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
        ),
      )),
    );
  }
}
