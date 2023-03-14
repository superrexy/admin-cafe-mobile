import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/banner_controller.dart';

class BannerView extends GetView<BannerController> {
  const BannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              const AppBarCustom(),
              const SizedBox(height: 20.0),
              Text(
                "Daftar Banner",
                style: AppTextStyle.heading2.copyWith(
                  color: AppColors.kPrimaryGreen2,
                ),
              ),
              const SizedBox(height: 12.0),
              SizedBox(
                width: Get.width,
                child: FormButton(
                  onPressed: () => Get.toNamed(Routes.FORMBANNER),
                  child: FittedBox(
                    child: Text(
                      "Tambah Banner",
                      style: AppTextStyle.mediumStyle
                          .copyWith(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0),
                    itemCount: controller.bannersData.length,
                    itemBuilder: (context, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: Get.height,
                            width: Get.width,
                            child: Image.network(
                              controller.bannersData[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  title: const Text("Hapus Banner"),
                                  content: const Text(
                                      "Apakah anda yakin ingin menghapus banner ini?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Batal"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        controller.deleteBannerData(
                                            controller.bannersData[index].id);
                                        Get.back();
                                      },
                                      child: const Text("Hapus"),
                                    ),
                                  ],
                                ));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
