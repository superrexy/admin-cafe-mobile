import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/payment/controllers/payment_check_controller.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentFailedView extends GetView<PaymentCheckController> {
  const PaymentFailedView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.kGray2,
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Icon(
                Icons.cancel,
                size: 50,
                color: Colors.red.shade700,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    "Pembayaran Gagal",
                    style: AppTextStyle.heading1.copyWith(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ),
              Text(
                controller.booking.value.total != null
                    ? controller.booking.value.total!.formatCurrencyIDR()
                    : "",
                style: AppTextStyle.heading2.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: Get.width,
                margin: const EdgeInsets.only(
                  top: 32,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Detail Pembayaran",
                      style: AppTextStyle.heading2,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Metode Pembayaran",
                          style: AppTextStyle.heading1.copyWith(
                            fontSize: 16,
                            color: AppColors.kGray,
                          ),
                        ),
                        Text(
                          controller.booking.value.paymentType ?? "",
                          style: AppTextStyle.body.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status",
                          style: AppTextStyle.heading1.copyWith(
                            fontSize: 16,
                            color: AppColors.kGray,
                          ),
                        ),
                        Text(
                          controller.booking.value.isPaid == "SETTLEMENT"
                              ? "Berhasil"
                              : controller.booking.value.isPaid == "EXPIRE"
                                  ? "Kadaluarsa"
                                  : "Gagal",
                          style: AppTextStyle.body.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal",
                          style: AppTextStyle.heading1.copyWith(
                            fontSize: 16,
                            color: AppColors.kGray,
                          ),
                        ),
                        Text(
                          controller.booking.value.createdAt != null
                              ? controller.booking.value.createdAt!
                                  .toLocal()
                                  .formatDateToString("dd MMMM, yyyy")
                              : "",
                          style: AppTextStyle.body.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Waktu",
                          style: AppTextStyle.heading1.copyWith(
                            fontSize: 16,
                            color: AppColors.kGray,
                          ),
                        ),
                        Text(
                          controller.booking.value.createdAt != null
                              ? controller.booking.value.createdAt!
                                  .toLocal()
                                  .formatDateToString("HH:mm")
                              : "",
                          style: AppTextStyle.body.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Pembayaran",
                          style: AppTextStyle.heading1.copyWith(
                            fontSize: 16,
                            color: AppColors.kGray,
                          ),
                        ),
                        Text(
                          controller.booking.value.total != null
                              ? controller.booking.value.total!
                                  .formatCurrencyIDR()
                              : "",
                          style: AppTextStyle.body.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 12,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => Get.offAllNamed(Routes.DASHBOARD_USER),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(64),
            ),
          ),
          child: Text(
            "Kembali ke Beranda",
            style: AppTextStyle.body.copyWith(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
