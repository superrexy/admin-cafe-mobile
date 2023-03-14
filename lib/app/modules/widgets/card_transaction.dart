import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/model/response/booking_response.dart';

class CardTransaction extends StatelessWidget {
  const CardTransaction(
      {super.key, required this.item, this.onDelete, this.onDone});
  final BookingData item;
  final Function()? onDelete;
  final Function()? onDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 12.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.kGray3,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryGreen1,
            ),
            child: Center(
              child: Text(
                'Order ${item.id}',
                style: AppTextStyle.body.copyWith(color: Colors.white),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nama Pemesan',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                    Text(
                      item.namaPemesan!,
                      style: AppTextStyle.mediumStyle.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ruang',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                    Text(
                      item.room!.nama!,
                      style: AppTextStyle.mediumStyle.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanggal',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                    Text(
                      item.tglPemesanan!.formatDateToString('dd MMMM yyyy'),
                      style: AppTextStyle.mediumStyle.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                    Text(
                      item.total!.formatCurrencyIDR(),
                      style: AppTextStyle.mediumStyle.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.kPrimaryGreen2,
                      ),
                    ),
                    Text(
                      item.isFinished! ? "Selesai" : "Belum Selesai",
                      style: AppTextStyle.mediumStyle.copyWith(
                        color: item.isPaid == "SETTLEMENT"
                            ? AppColors.kPrimaryGreen2
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.kPrimaryGreen1,
            ),
            child: Row(
              children: [
                Visibility(
                  visible: item.isFinished!,
                  child: Expanded(
                    child: GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12.0)),
                        ),
                        child: Center(
                          child: Text(
                            "Hapus Transaksi",
                            style: AppTextStyle.regularStyle
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !item.isFinished!,
                  child: Expanded(
                    child: GestureDetector(
                      onTap: onDone,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(12.0)),
                        ),
                        child: Center(
                          child: Text("Jadikan Selesai",
                              style: AppTextStyle.regularStyle
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
