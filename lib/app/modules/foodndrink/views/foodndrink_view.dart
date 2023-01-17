import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/foodndrink_controller.dart';

class FoodndrinkView extends GetView<FoodndrinkController> {
  const FoodndrinkView({Key? key}) : super(key: key);
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
                "Daftar Makanan dan Minuman",
                style: AppTextStyle.heading2.copyWith(
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
                            hintText: "Cari Makanan dan Minuman",
                            controller: TextEditingController(),
                            onChanged: (val) => controller.searchRoom(val),
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

                                      controller.sortingPrice(value.toString());
                                    },
                                  ),
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
                                        Get.toNamed(Routes.FORMFOODNDRINK),
                                    child: FittedBox(
                                      child: Text(
                                        "Tambah Data",
                                        style: AppTextStyle.mediumStyle
                                            .copyWith(
                                                fontSize: 14,
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
              const SizedBox(height: 16.0),
              Expanded(
                child: Obx(
                  () => controller.foodsnDrinks.isEmpty
                      ? Center(
                          child: Text(
                            "Data Makanan & Minuman Kosong",
                            style: AppTextStyle.mediumStyle
                                .copyWith(fontSize: 18.0),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.foodsnDrinks.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final TextEditingController _noteController =
                                TextEditingController();
                            final item = controller.foodsnDrinks[index];
                            final isChecked = item.isChecked.obs;

                            if (isChecked.value!) {
                              _noteController.text = item.note ?? "";
                            }

                            return Obx(() {
                              return Container(
                                height: !isChecked.value!
                                    ? Get.height * 0.15
                                    : args?['onSelect'] != null
                                        ? Get.height * 0.2
                                        : Get.height * 0.15,
                                margin: const EdgeInsets.only(bottom: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 100.0,
                                          width: 120.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  item.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        IntrinsicWidth(
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.nama,
                                                  style: AppTextStyle.boldStyle
                                                      .copyWith(fontSize: 16.0),
                                                ),
                                                Text(item.harga
                                                    .formatCurrencyIDR()),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8.0),
                                        args?['onSelect'] == null
                                            ? Visibility(
                                                visible: controller
                                                        .dashboardController
                                                        .userProfile
                                                        .value
                                                        .role ==
                                                    "admin",
                                                child: Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () =>
                                                            Get.toNamed(
                                                                Routes
                                                                    .FORMFOODNDRINK,
                                                                arguments: {
                                                              'food_id':
                                                                  item.id,
                                                            }),
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
                                                                  "Hapus Makanan & Minuman"),
                                                              content: const Text(
                                                                  "Apakah anda yakin ingin menghapus makanan / minuman ini?"),
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
                                                                        .deleteFoodnDrink(
                                                                            item);
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
                                                          Icons.delete_outline,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Expanded(
                                                child: CheckboxListTile(
                                                  value: item.isChecked,
                                                  onChanged: (value) {
                                                    controller
                                                        .updateCartChecked(
                                                      item,
                                                    );
                                                  },
                                                ),
                                              ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: isChecked.value!,
                                      child: Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: FormInputField(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                hintText: "Masukkan Catatan",
                                                controller: _noteController,
                                                onChanged: (val) {
                                                  controller.updateCartNote(
                                                      item, val);
                                                },
                                              ),
                                            ),
                                            const SizedBox(width: 12.0),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    top: 4.0),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  border: Border.all(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        if (item.quantity! >
                                                            1) {
                                                          controller
                                                              .updateCartQuantity(
                                                                  item,
                                                                  item.quantity! -
                                                                      1);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Text(
                                                          item.quantity
                                                              .toString(),
                                                          style: AppTextStyle
                                                              .mediumStyle
                                                              .copyWith(
                                                                  fontSize:
                                                                      16.0),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .updateCartQuantity(
                                                                item,
                                                                item.quantity! +
                                                                    1);
                                                      },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        ),
                ),
              ),
              Visibility(
                visible: Get.arguments?['onSelect'] != null ? true : false,
                child: SizedBox(
                  width: Get.width,
                  child: FormButton(
                    child: const Text("Simpan Perubahan"),
                    onPressed: () => controller.addFoodChecked(),
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
