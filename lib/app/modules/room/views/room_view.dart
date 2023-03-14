import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/room_controller.dart';

class RoomView extends GetView<RoomController> {
  const RoomView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
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
                "Daftar Ruangan",
                style: AppTextStyle.heading1.copyWith(
                  fontSize: 22,
                  color: AppColors.kPrimaryGreen2,
                ),
              ),
              const SizedBox(height: 12.0),
              args?['onSelect'] == null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 42.0),
                          child: FormInputField(
                            hintText: "Cari Ruangan",
                            controller: TextEditingController(),
                            onChanged: (val) {
                              controller.searchRoom(val);
                            },
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          children: [
                            Obx(
                              () => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: AppColors.kPrimaryGreen1,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      value: controller.orderItemSelected.value,
                                      items: controller.orderItems
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e['value'],
                                              child: Text(
                                                e['key']!,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        controller.orderItemSelected.value =
                                            value.toString();
                                        controller
                                            .sortingPrice(value.toString());
                                      }),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Visibility(
                              visible: controller.dashboardController
                                      .userProfile.value.role ==
                                  "admin",
                              child: Expanded(
                                child: IntrinsicHeight(
                                  child: FormButton(
                                    onPressed: () =>
                                        Get.toNamed(Routes.FORMROOM),
                                    child: FittedBox(
                                      child: Text(
                                        "Tambah Ruangan",
                                        style: AppTextStyle.mediumStyle
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 12.0),
              Expanded(
                child: Obx(
                  () => controller.rooms.isEmpty
                      ? Center(
                          child: Text(
                            "Data Ruangan Kosong",
                            style: AppTextStyle.mediumStyle
                                .copyWith(fontSize: 18.0),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.rooms.length,
                          itemBuilder: (context, index) {
                            final room = controller.rooms[index];
                            return args?['onSelect'] != null
                                ? GestureDetector(
                                    onTap: () {
                                      if (room.quota == 0) {
                                        Get.snackbar(
                                          "Gagal",
                                          "Ruangan Penuh",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        Get.back(result: {
                                          'id': room.id,
                                          'item': room,
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 12.0),
                                      padding: const EdgeInsets.all(20.0),
                                      foregroundDecoration: room.quota == 0
                                          ? BoxDecoration(
                                              color: Colors.black26,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )
                                          : null,
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryGreen3,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: CachedNetworkImage(
                                              imageUrl: room.image,
                                              width: 230,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          const SizedBox(height: 10.0),
                                          Center(
                                            child: IntrinsicWidth(
                                              child: Text(
                                                room.nama,
                                                style:
                                                    AppTextStyle.body.copyWith(
                                                  fontSize: 18,
                                                  color:
                                                      AppColors.kPrimaryGreen2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Deskripsi",
                                            style: AppTextStyle.body.copyWith(
                                              color: AppColors.kPrimaryGreen2,
                                              fontSize: 16,
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: Text(
                                              "Fasilitas: ${room.fasilitas}",
                                              style: AppTextStyle.body.copyWith(
                                                color: AppColors.kPrimaryGreen2,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: Text(
                                              "Kapasitas : ${room.kapasitas}",
                                              style: AppTextStyle.body.copyWith(
                                                color: AppColors.kPrimaryGreen2,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: Text(
                                              "Waktu : ${room.waktu}",
                                              style: AppTextStyle.body.copyWith(
                                                color: AppColors.kPrimaryGreen2,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: Text(
                                              "Quota : ${room.quota}",
                                              style: AppTextStyle.body.copyWith(
                                                color: AppColors.kPrimaryGreen2,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          IntrinsicWidth(
                                            child: Text(
                                              "Harga : ${room.harga.formatCurrencyIDR()}",
                                              style: AppTextStyle.body.copyWith(
                                                color: AppColors.kPrimaryGreen2,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10.0),
                                          args?['onSelect'] == null
                                              ? Visibility(
                                                  visible: controller
                                                          .dashboardController
                                                          .userProfile
                                                          .value
                                                          .role ==
                                                      "admin",
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () =>
                                                            Get.toNamed(
                                                          Routes.FORMROOM,
                                                          arguments: {
                                                            'room_id': room.id,
                                                          },
                                                        ),
                                                        icon: const Icon(
                                                            Icons.edit_outlined,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                      const SizedBox(
                                                          width: 10.0),
                                                      IconButton(
                                                        onPressed: () {
                                                          Get.dialog(
                                                            AlertDialog(
                                                              title: const Text(
                                                                  "Hapus Ruangan"),
                                                              content: const Text(
                                                                  "Apakah anda yakin ingin menghapus ruangan ini?"),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () => Get
                                                                          .back(),
                                                                  child:
                                                                      const Text(
                                                                    "Batal",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .deleteRoom(
                                                                            room.id);
                                                                    Get.close(
                                                                        1);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "Hapus",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Colors.red),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(bottom: 12.0),
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.kPrimaryGreen3,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: CachedNetworkImage(
                                            imageUrl: room.image,
                                            width: 230,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Center(
                                          child: IntrinsicWidth(
                                            child: Text(
                                              room.nama,
                                              style: AppTextStyle.body.copyWith(
                                                fontSize: 18,
                                                color: AppColors.kPrimaryGreen2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Deskripsi",
                                          style: AppTextStyle.body.copyWith(
                                            color: AppColors.kPrimaryGreen2,
                                            fontSize: 16,
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Text(
                                            "Fasilitas: ${room.fasilitas}",
                                            style: AppTextStyle.body.copyWith(
                                              color: AppColors.kPrimaryGreen2,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Text(
                                            "Kapasitas : ${room.kapasitas}",
                                            style: AppTextStyle.body.copyWith(
                                              color: AppColors.kPrimaryGreen2,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Text(
                                            "Waktu : ${room.waktu}",
                                            style: AppTextStyle.body.copyWith(
                                              color: AppColors.kPrimaryGreen2,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Text(
                                            "Quota : ${room.quota}",
                                            style: AppTextStyle.body.copyWith(
                                              color: AppColors.kPrimaryGreen2,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Text(
                                            "Harga : ${room.harga.formatCurrencyIDR()}",
                                            style: AppTextStyle.body.copyWith(
                                              color: AppColors.kPrimaryGreen2,
                                              fontSize: 14,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        args?['onSelect'] == null
                                            ? Visibility(
                                                visible: controller
                                                        .dashboardController
                                                        .userProfile
                                                        .value
                                                        .role ==
                                                    'admin',
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () =>
                                                          Get.toNamed(
                                                        Routes.FORMROOM,
                                                        arguments: {
                                                          'room_id': room.id,
                                                        },
                                                      ),
                                                      icon: const Icon(
                                                          Icons.edit_outlined,
                                                          color: Colors.green),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    IconButton(
                                                      onPressed: () {
                                                        Get.dialog(
                                                          AlertDialog(
                                                            title: const Text(
                                                                "Hapus Ruangan"),
                                                            content: const Text(
                                                                "Apakah anda yakin ingin menghapus ruangan ini?"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Get.back(),
                                                                child:
                                                                    const Text(
                                                                  "Batal",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  controller
                                                                      .deleteRoom(
                                                                          room.id);
                                                                  Get.close(1);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Hapus",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .red),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete_outline,
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  );
                            ;
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
