import 'package:admin_cafe_mobile/app/model/response/profile_response.dart';
import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required this.user});
  final ProfileData user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      focusColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Colors.transparent,
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "MENU",
                      style: AppTextStyle.body.copyWith(
                          fontSize: 16, color: AppColors.kPrimaryGreen2),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
          SidebarItem(
            imagePath: AppImages.icRuangan2,
            title: "Ruangan",
            onTap: () => Get.toNamed(Routes.ROOM),
          ),
          SidebarItem(
            imagePath: AppImages.icPemesanan,
            title: "Pemesanan",
            onTap: () => Get.toNamed(Routes.BOOKING),
          ),
          SidebarItem(
            imagePath: AppImages.icMakanan,
            title: "Makanan dan Minuman",
            onTap: () => Get.toNamed(Routes.FOODNDRINK),
          ),
          SidebarItem(
            isVisible: user.role == "admin" ? true : false,
            imagePath: AppImages.icTransaksi,
            title: "Data Transaksi",
            onTap: () => Get.toNamed(Routes.TRANSACTION),
          ),
          SidebarItem(
            imagePath: AppImages.icLogout,
            title: "Keluar",
            onTap: () {
              Get.dialog(
                AlertDialog(
                  title: Text("Keluar"),
                  content: Text("Apakah anda yakin ingin keluar?"),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: Text("Tidak"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.offAllNamed(Routes.LOGIN);
                        Get.delete<DashboardController>();
                        Storage.removeValue(Constants.token);
                      },
                      child: Text("Ya"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
