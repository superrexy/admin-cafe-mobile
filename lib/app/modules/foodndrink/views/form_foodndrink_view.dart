import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/foodndrink/controllers/form_foodndrink_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/form_input_file.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';

class FormFoodndrinkView extends GetView<FormFoodndrinkController> {
  const FormFoodndrinkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 32.0),
            margin: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                const AppBarCustom(),
                const SizedBox(height: 40.0),
                Text(
                  "${controller.isUpdate ? "Edit" : "Tambah"} Makanan dan Minuman",
                  style: AppTextStyle.heading1.copyWith(
                    color: AppColors.kPrimaryGreen2,
                  ),
                ),
                const SizedBox(height: 30.0),
                Form(
                  key: controller.foodFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(
                        label: "Foto Makanan / Minuman",
                        isRequired: true,
                      ),
                      GetBuilder<FormFoodndrinkController>(
                        init: FormFoodndrinkController(),
                        initState: (_) {},
                        builder: (_) {
                          return FormInputFile(
                            label: "Tambahkan Foto Makanan / Minuman",
                            valueImage: controller.image,
                            changeImage: () => controller.getImage(),
                            resetImage: () => controller.resetImage(),
                            fromInternet: controller.isImageFromInternet,
                            imageUrl: controller.imageUrl,
                          );
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Nama Makanan / Minuman",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Nama Makanan / Minuman tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Nama Makanan / Minuman",
                        controller: controller.foodNameController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Harga",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Harga tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Harga",
                        controller: controller.foodPriceController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Deskripsi",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Deskripsi tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Deskripsi",
                        controller: controller.foodDescController,
                        textInputAction: TextInputAction.next,
                        isTextArea: true,
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormButton(
                            type: FormButtonType.danger,
                            onPressed: () => Get.back(),
                            child: Text(
                              "Batal",
                              style: AppTextStyle.mediumStyle.copyWith(
                                color: AppColors.kPrimaryGreen2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          FormButton(
                            onPressed: () => controller.onSubmit(),
                            child: Text(
                              "Simpan",
                              style: AppTextStyle.mediumStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
