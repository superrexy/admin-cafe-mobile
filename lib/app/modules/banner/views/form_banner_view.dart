import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/banner/controllers/form_banner_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/form_input_file.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormBannerView extends GetView<FormBannerController> {
  const FormBannerView({Key? key}) : super(key: key);
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
                  "${controller.isUpdate ? "Edit" : "Tambah"} Banner",
                  style: AppTextStyle.heading1.copyWith(
                    color: AppColors.kPrimaryGreen2,
                  ),
                ),
                const SizedBox(height: 30.0),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(
                        label: "Foto Banner",
                        isRequired: true,
                      ),
                      GetBuilder<FormBannerController>(
                        init: FormBannerController(),
                        initState: (_) {},
                        builder: (_) {
                          return FormInputFile(
                            label: "Tambahkan Foto Banner",
                            valueImage: controller.image,
                            changeImage: () => controller.getImage(),
                            resetImage: () => controller.resetImage(),
                            fromInternet: controller.isImageFromInternet,
                            imageUrl: controller.imageUrl,
                          );
                        },
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
