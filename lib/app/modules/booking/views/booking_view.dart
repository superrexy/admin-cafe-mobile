import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/booking_controller.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);
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
                "Daftar Pesanan",
                style: AppTextStyle.heading2.copyWith(
                  color: AppColors.kPrimaryGreen2,
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 42.0),
                child: FormInputField(
                  hintText: "Cari Pesanan",
                  controller: TextEditingController(),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
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
                          onChanged: (value) => controller
                              .orderItemSelected.value = value.toString(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: IntrinsicHeight(
                      child: FormButton(
                        onPressed: () => Get.toNamed(Routes.FORMBOOKING),
                        child: FittedBox(
                          child: Text(
                            "Tambah Pesanan",
                            style: AppTextStyle.mediumStyle
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Obx(
                  () {
                    return controller.bookingsData.isEmpty
                        ? Center(
                            child: Text(
                              "Data Masih Kosong",
                              style: AppTextStyle.heading2,
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: ((context, index) {
                              final item = controller.bookingsData[index];
                              return Container(
                                width: Get.width,
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.only(bottom: 12.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.kGray,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.tglPemesanan
                                                .formatDateToString('yyyy'),
                                            style: AppTextStyle.regularStyle
                                                .copyWith(fontSize: 10),
                                          ),
                                          Text(
                                            item.tglPemesanan
                                                .formatDateToString('dd'),
                                            style: AppTextStyle.heading2
                                                .copyWith(fontSize: 14),
                                          ),
                                          Text(
                                            item.tglPemesanan
                                                .formatDateToString('MMM'),
                                            style: AppTextStyle.regularStyle
                                                .copyWith(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order: #${item.id}",
                                            style: AppTextStyle.regularStyle
                                                .copyWith(fontSize: 10),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              item.namaPemesan,
                                              style: AppTextStyle.heading2
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              item.emailPemesan,
                                              style: AppTextStyle.regularStyle
                                                  .copyWith(fontSize: 10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "Total",
                                              style: AppTextStyle.regularStyle
                                                  .copyWith(fontSize: 13),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              item.total.formatCurrencyIDR(),
                                              style: AppTextStyle.boldStyle
                                                  .copyWith(fontSize: 14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          FittedBox(
                                            child: Text(
                                              "Status",
                                              style: AppTextStyle.regularStyle
                                                  .copyWith(fontSize: 13),
                                            ),
                                          ),
                                          FittedBox(
                                            child: Text(
                                              item.isPaid
                                                  ? "Lunas"
                                                  : "Belum Dibayar",
                                              style: AppTextStyle.boldStyle
                                                  .copyWith(
                                                      fontSize: 12,
                                                      color: item.isPaid
                                                          ? Colors.green
                                                          : Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            itemCount: controller.bookingsData.length,
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
