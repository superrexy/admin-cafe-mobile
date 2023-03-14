import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/room/controllers/form_room_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/form_input_file.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';

class FormRoomView extends GetView<FormRoomController> {
  const FormRoomView({Key? key}) : super(key: key);
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
                  "${controller.isUpdate ? "Edit" : "Buat"} Ruangan",
                  style: AppTextStyle.heading1.copyWith(
                    color: AppColors.kPrimaryGreen2,
                  ),
                ),
                const SizedBox(height: 30.0),
                Form(
                  key: controller.roomFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(
                        label: "Foto Ruangan",
                        isRequired: true,
                      ),
                      GetBuilder<FormRoomController>(
                        init: FormRoomController(),
                        initState: (_) {},
                        builder: (_) {
                          return FormInputFile(
                            label: "Tambahkan Foto Ruangan",
                            valueImage: controller.image,
                            changeImage: () => controller.getImage(),
                            resetImage: () => controller.resetImage(),
                            fromInternet: controller.isImageFromInternet,
                            imageUrl: Get.arguments != null
                                ? controller.imageUrl
                                : null,
                          );
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Nama Ruangan",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Nama Ruangan tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Nama Ruangan",
                        controller: controller.roomNameController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Fasilitas",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Fasilitas tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Fasilitas",
                        controller: controller.roomFacilityController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Kapasitas",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Kapasitas tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Kapasitas",
                        controller: controller.roomCapacityController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Waktu",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Waktu tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Waktu",
                        controller: controller.roomRentHourController,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Quota Ruangan",
                        isRequired: true,
                      ),
                      FormInputField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Quota ruangan tidak boleh kosong";
                          }
                          return null;
                        },
                        hintText: "Masukkan Quota Ruangan",
                        controller: controller.roomQuotaController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
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
                        controller: controller.roomPriceController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
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
                            onPressed: () => controller.createRoom(),
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
