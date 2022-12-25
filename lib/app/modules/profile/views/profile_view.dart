import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: Get.statusBarHeight * 0.1, left: 16.0, right: 16.0),
            margin: EdgeInsets.only(bottom: Get.height * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.kPrimaryGreen1,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        SvgPicture.asset(
                          AppImages.logo,
                          width: 100,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 12.0),
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.IMAGE_PROFILE),
                          child: controller.dashboardController.userProfile
                                      .value.imageProfile ==
                                  null
                              ? Image.asset(
                                  AppImages.imgUser,
                                  width: 45,
                                  height: 45,
                                )
                              : Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        controller.dashboardController
                                            .userProfile.value.imageProfile!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Profile",
                  style: AppTextStyle.body.copyWith(
                    fontSize: 24,
                    color: AppColors.kPrimaryGreen2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 30.0),
                  decoration: const BoxDecoration(
                    color: AppColors.kPrimaryGreen3,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Data Profile",
                        style: AppTextStyle.heading1.copyWith(
                          fontSize: 22,
                          color: AppColors.kPrimaryGreen2,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const FormLabel(
                                label: "Nama Depan", isRequired: true),
                            FormInputField(
                              hintText: "Masukkan Nama Depan Anda",
                              controller: controller.firstNameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Nama Depan tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const FormLabel(
                                label: "Nama Belakang", isRequired: true),
                            FormInputField(
                              hintText: "Masukkan Nama Belakang Anda",
                              controller: controller.lastNameController,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Nama Belakang tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const FormLabel(label: "Nomer Telepon"),
                            FormInputField(
                              hintText: "Masukkan Nomer Telepon Anda",
                              controller: controller.phoneController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const FormLabel(label: "Alamat"),
                            FormInputField(
                              hintText: "Masukkan Alamat Anda",
                              controller: controller.addressController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.streetAddress,
                              isTextArea: true,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Center(
                              child: FormButton(
                                onPressed: () => controller.updateProfile(),
                                child: Text(
                                  "Simpan Perubahan",
                                  style: AppTextStyle.regularStyle
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
