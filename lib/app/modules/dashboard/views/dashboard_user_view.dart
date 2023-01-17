import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../common/values/app_colors.dart';
import '../../../common/values/app_images.dart';
import '../../../common/utils/extensions.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/sidebar.dart';

class DashboardUserView extends GetView<DashboardController> {
  const DashboardUserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: Sidebar(user: controller.userProfile.value),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: Get.statusBarHeight * 0.5, left: 16.0, right: 16.0),
            color: AppColors.kPrimaryGreen3,
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
                          onPressed: () => controller.openDrawer(),
                          icon: const Icon(
                            Icons.menu,
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
                        const Icon(Icons.notifications_outlined),
                        const SizedBox(width: 12.0),
                        Obx(
                          () => GestureDetector(
                            onTap: () => Get.toNamed(Routes.PROFILE),
                            child: controller.userProfile.value.imageProfile ==
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
                                        image: NetworkImage(controller
                                            .userProfile.value.imageProfile!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => controller.bookingData.isNotEmpty
                      ? Visibility(
                          visible: DateTime.now().isBefore(
                            controller.bookingData.first.tglPemesanan!,
                          ),
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimaryGreen1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jangan Lupa Pesanan Booking Kamu",
                                  style: AppTextStyle.mediumStyle.copyWith(
                                    fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  controller.bookingData.first.tglPemesanan!
                                      .formatDateToString('dd MMMM yyyy'),
                                  style: AppTextStyle.boldStyle.copyWith(
                                    fontSize: 16.0,
                                    color: AppColors.kPrimaryGreen3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                const SizedBox(height: 8.0),
                Flexible(
                  child: GridView.count(
                    crossAxisCount: 3,
                    children: [
                      MenuItemButton(
                        label: "Menu",
                        image: AppImages.icMakanan,
                        onTap: () => Get.toNamed(Routes.FOODNDRINK),
                      ),
                      MenuItemButton(
                        label: "Ruangan",
                        image: AppImages.icRuangan2,
                        onTap: () => Get.toNamed(Routes.ROOM),
                      ),
                      MenuItemButton(
                        label: "Pesanan",
                        image: AppImages.icPemesanan,
                        onTap: () => Get.toNamed(Routes.BOOKING),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    height: Get.height * 0.25,
                    child: Image.asset(
                      AppImages.imgIceCream,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemButton extends StatelessWidget {
  const MenuItemButton({
    Key? key,
    required this.label,
    this.onTap,
    required this.image,
  }) : super(key: key);
  final String label;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.kPrimaryGreen1,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(image),
          ),
          const SizedBox(height: 8.0),
          Text(
            label,
            maxLines: 2,
            style: AppTextStyle.mediumStyle.copyWith(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
