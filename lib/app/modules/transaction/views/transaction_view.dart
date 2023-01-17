import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/card_transaction.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({Key? key}) : super(key: key);
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
                "Daftar Transaksi",
                style: AppTextStyle.heading2.copyWith(
                  color: AppColors.kPrimaryGreen2,
                ),
              ),
              const SizedBox(height: 12.0),
              Expanded(
                child: Obx(() => controller.bookingsData.isEmpty
                    ? Center(
                        child: Text(
                          "Tidak ada transaksi",
                          style: AppTextStyle.body,
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.bookingsData.length,
                        itemBuilder: (context, index) {
                          final booking = controller.bookingsData[index];
                          return CardTransaction(
                            item: booking,
                            onDelete: () =>
                                controller.deleteBooking(booking.id!),
                            onDone: () {
                              controller.paidBooking(booking, booking.id!);
                            },
                          );
                        },
                      )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
