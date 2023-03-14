import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBarCustom(),
                const SizedBox(height: 24.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Pemesanan",
                            style: AppTextStyle.body.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0.0),
                              splashFactory: NoSplash.splashFactory,
                              foregroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                            ),
                            onPressed: () {
                              Get.bottomSheet(
                                enableDrag: false,
                                DraggableScrollableSheet(
                                  initialChildSize: 0.6,
                                  minChildSize: 0.6,
                                  maxChildSize: 1.0,
                                  builder: (context, scrollController) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Total Rincian Pesanan",
                                                style: AppTextStyle.heading1,
                                                textAlign: TextAlign.start,
                                              ),
                                              IconButton(
                                                onPressed: () => Get.back(),
                                                icon: const Icon(
                                                  Icons
                                                      .highlight_remove_outlined,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Ruangan",
                                                    style: AppTextStyle
                                                        .mediumStyle),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Visibility(
                                                  visible: controller
                                                      .formBookingController
                                                      .tempRooms
                                                      .isEmpty,
                                                  child: Text(
                                                      "Pilih Ruangan Terlebih Dahulu",
                                                      style: AppTextStyle
                                                          .regularStyle),
                                                ),
                                                Visibility(
                                                  visible: controller
                                                      .formBookingController
                                                      .tempRooms
                                                      .isNotEmpty,
                                                  child: Column(
                                                    children: controller
                                                        .formBookingController
                                                        .tempRooms
                                                        .map(
                                                          (e) => Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                e.nama,
                                                                style: AppTextStyle
                                                                    .mediumStyle,
                                                              ),
                                                              Text(
                                                                e.harga
                                                                    .formatCurrencyIDR(),
                                                                style: AppTextStyle
                                                                    .mediumStyle,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Text("Makanan & Minuman",
                                                    style: AppTextStyle
                                                        .mediumStyle),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Visibility(
                                                  visible: controller
                                                      .formBookingController
                                                      .tempFoodsChecklist
                                                      .isEmpty,
                                                  child: Text(
                                                      "Pilih Makanan & Minuman Terlebih Dahulu",
                                                      style: AppTextStyle
                                                          .regularStyle),
                                                ),
                                                Visibility(
                                                  visible: controller
                                                      .formBookingController
                                                      .tempFoodsChecklist
                                                      .isNotEmpty,
                                                  child: Column(
                                                    children: controller
                                                        .formBookingController
                                                        .tempFoodsChecklist
                                                        .map(
                                                          (e) => Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        6.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  "${e.nama} x ${e.quantity}",
                                                                  style: AppTextStyle
                                                                      .mediumStyle,
                                                                ),
                                                                Text(
                                                                  (e.harga *
                                                                          e.quantity!)
                                                                      .formatCurrencyIDR(),
                                                                  style: AppTextStyle
                                                                      .mediumStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Total",
                                                        style: AppTextStyle
                                                            .mediumStyle),
                                                    Text(
                                                      controller
                                                          .formBookingController
                                                          .totalPrice
                                                          .value
                                                          .formatCurrencyIDR(),
                                                      style: AppTextStyle
                                                          .mediumStyle,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Lihat Detail",
                              style: AppTextStyle.boldStyle.copyWith(
                                color: AppColors.kPrimaryGreen2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 6.0),
                        child: const Divider(),
                      ),
                      Row(
                        children: [
                          Text(
                            "Nama Pemesan",
                            style: AppTextStyle.body.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.kGray,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            controller
                                .formBookingController.nameController.text,
                            style: AppTextStyle.boldStyle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: AppTextStyle.body.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.kGray,
                            ),
                          ),
                          const Spacer(),
                          Obx(
                            () => Text(
                              controller.formBookingController.totalPrice.value
                                  .formatCurrencyIDR(),
                              style: AppTextStyle.boldStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  "Metode Pembayaran",
                  style: AppTextStyle.heading2.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16.0),
                Obx(
                  () => Column(
                    children: [
                      PaymentMethodCard(
                        paymentMethod: "GoPay",
                        radioValue: controller.selectedBank.value,
                        onChanged: (val) =>
                            controller.selectedBank.value = val.toString(),
                        paymentMethodImage: AppImages.icGopay,
                      ),
                      PaymentMethodCard(
                        paymentMethod: "ShopeePay",
                        radioValue: controller.selectedBank.value,
                        onChanged: (val) =>
                            controller.selectedBank.value = val.toString(),
                        paymentMethodImage: AppImages.icShopeepay,
                      ),
                      PaymentMethodCard(
                        paymentMethod: "OVO",
                        radioValue: controller.selectedBank.value,
                        onChanged: (val) =>
                            controller.selectedBank.value = val.toString(),
                        paymentMethodImage: AppImages.icOVO,
                      ),
                      PaymentMethodCard(
                        paymentMethod: "Dana",
                        radioValue: controller.selectedBank.value,
                        onChanged: (val) =>
                            controller.selectedBank.value = val.toString(),
                        paymentMethodImage: AppImages.icDana,
                      ),
                      PaymentMethodCard(
                        paymentMethod: "LinkAja",
                        radioValue: controller.selectedBank.value,
                        onChanged: (val) =>
                            controller.selectedBank.value = val.toString(),
                        paymentMethodImage: AppImages.icLinkAja,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 120,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Total Pembayaran",
                  style: AppTextStyle.body.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.kGray,
                  ),
                ),
                const Spacer(),
                Obx(
                  () => Text(
                    controller.formBookingController.totalPrice.value
                        .formatCurrencyIDR(),
                    style: AppTextStyle.heading2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            SizedBox(
              width: Get.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.selectedBank.value == ""
                      ? null
                      : () async {
                          if (controller.selectedBank.value == "OVO") {
                            Get.toNamed(Routes.PAYMENT_OVO_MOBILE_PHONE);
                          } else {
                            controller.formBookingController.createBooking(
                                paymentType: controller.selectedBank.value);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.selectedBank.value == ""
                        ? AppColors.kGray
                        : AppColors.kPrimaryGreen2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: const Text("Bayar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    required this.paymentMethod,
    required this.paymentMethodImage,
    required this.radioValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);
  final String paymentMethod;
  final String paymentMethodImage;
  final Object? radioValue;
  final Function(Object?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged!(paymentMethod),
      child: Container(
        width: Get.width,
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 4.0,
        ),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: AppColors.kGray3,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  paymentMethodImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Text(
              paymentMethod,
              style: AppTextStyle.boldStyle.copyWith(
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Radio(
              value: paymentMethod,
              groupValue: radioValue,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
