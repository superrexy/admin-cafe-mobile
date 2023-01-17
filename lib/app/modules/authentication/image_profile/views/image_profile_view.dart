import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/image_profile_controller.dart';

class ImageProfileView extends GetView<ImageProfileController> {
  const ImageProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(vertical: 43.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Tambahkan foto.",
                  style: AppTextStyle.boldStyle.copyWith(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Tambahkan foto agar yang lain\nmengenali anda.",
                  style: AppTextStyle.regularStyle
                      .copyWith(color: AppColors.kGray, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                GetBuilder<ImageProfileController>(
                  init: ImageProfileController(),
                  builder: ((controller) {
                    return controller.image == null
                        ? GestureDetector(
                            onTap: () => controller.getImage(),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: AppColors.kPrimaryGreen2,
                                  width: 2,
                                ),
                              ),
                              child: Image.asset(
                                AppImages.imgUser,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 140,
                            height: 140,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(controller.image!),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: AppColors.kPrimaryGreen2,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () => controller.resetImage(),
                                    icon: const Icon(
                                      Icons.close_sharp,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                  }),
                ),
              ],
            ),
            Column(
              children: [
                GetBuilder<ImageProfileController>(
                  builder: ((controller) {
                    return controller.image == null
                        ? const SizedBox()
                        : FormButton(
                            onPressed: () => controller.uploadImageProfile(),
                            child: Text(
                              "Unggah Foto",
                              style: AppTextStyle.regularStyle
                                  .copyWith(color: Colors.white),
                            ),
                          );
                  }),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextButton(
                  onPressed: () => Get.offAllNamed(Routes.DASHBOARD_USER),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Lewati",
                    style: AppTextStyle.body
                        .copyWith(fontSize: 14.0, color: AppColors.kGray),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
