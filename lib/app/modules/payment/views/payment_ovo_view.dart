import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/payment/controllers/payment_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentOvoView extends GetView<PaymentController> {
  const PaymentOvoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray2,
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
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 32.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Masukkan nomor handphone kamu yang terdaftar di aplikasi OVO",
                        style: AppTextStyle.body.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      FormInputField(
                        hintText: "Nomor OVO Kamu",
                        controller: controller.mobileNumberController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          controller.mobileNumberIsFilled.value =
                              value.isNotEmpty;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nomor OVO tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                Text(
                  "1. Buka aplikasi OVO kamu dan cek notifikasi untuk menyelesaikan pembayaran.",
                  style: AppTextStyle.body.copyWith(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "2. Pastikan kamu melakukan pembayaran dalam waktu 30 detik untuk menghindari pembatalan order otomatis.",
                  style: AppTextStyle.body.copyWith(
                    fontSize: 18,
                  ),
                )
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
        height: Get.height * 0.075,
        child: Column(
          children: [
            SizedBox(
              width: Get.width,
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    controller.formBookingController.createBooking(
                      paymentType: controller.selectedBank.value,
                      mobileNumber: controller.mobileNumberController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        controller.mobileNumberIsFilled.value == false
                            ? AppColors.kGray
                            : AppColors.kPrimaryGreen2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: const Text("Kirim"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
