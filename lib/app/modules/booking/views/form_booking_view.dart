import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

// ignore_for_file: depend_on_referenced_packages

class FormBookingView extends GetView<FormBookingController> {
  const FormBookingView({Key? key}) : super(key: key);
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
              children: [
                const AppBarCustom(),
                const SizedBox(height: 40.0),
                Text(
                  "Tambah Pesanan",
                  style: AppTextStyle.heading1.copyWith(
                    color: AppColors.kPrimaryGreen2,
                  ),
                ),
                const SizedBox(height: 30.0),
                Form(
                  key: controller.bookingFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FormLabel(
                        label: "Nama Pemesan",
                        isRequired: true,
                      ),
                      FormInputField(
                        hintText: "Masukkan Nama Pemesan",
                        controller: controller.nameController,
                        textInputAction: TextInputAction.next,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Nama Pemesan tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Email Pemesan",
                        isRequired: true,
                      ),
                      FormInputField(
                        hintText: "Masukkan Email Pemesan",
                        controller: controller.emailController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Nama Pemesan tidak boleh kosong";
                          } else if (!GetUtils.isEmail(val)) {
                            return "Email tidak valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Tanggal Pesanan",
                        isRequired: true,
                      ),
                      FormInputField(
                        hintText: "Pilih Tanggal Pesanan",
                        controller: controller.dateController,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        keyboardType: TextInputType.none,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: controller.selectedDate,
                            firstDate: DateTime(
                              2000,
                            ),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            controller.selectedDate = pickedDate;
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);

                            controller.dateController.text = formattedDate;
                          } else {
                            print("Date is not selected");
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Tanggal Pesanan tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Ruangan",
                        isRequired: true,
                      ),
                      FormInputField(
                        hintText: "Pilih Ruangan",
                        controller: controller.roomController,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        onTap: () async {
                          final room = await Get.toNamed(
                            Routes.ROOM,
                            arguments: {
                              "onSelect": true,
                            },
                          );

                          if (room != null) {
                            if (controller.tempRooms.isEmpty) {
                              controller.tempRooms.addIf(
                                  controller.tempRooms.isEmpty, room['item']);
                            } else {
                              if (controller.tempRooms.first.id !=
                                  room['item'].id) {
                                controller.tempRooms.clear();
                                controller.tempRooms.add(room['item']);
                              }
                            }

                            controller.roomController.text =
                                controller.tempRooms.first.nama;
                          }
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Ruangan tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      const FormLabel(
                        label: "Makanan & Minuman",
                        isRequired: true,
                      ),
                      FormInputField(
                        hintText: "Pilih Makanan & Minuman",
                        controller: controller.foodController,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        onTap: () {
                          Get.toNamed(
                            Routes.FOODNDRINK,
                            arguments: {
                              "onSelect": true,
                              "isUpdateMenu":
                                  controller.tempFoodsChecklist.isNotEmpty
                                      ? true
                                      : false,
                            },
                          );
                        },
                        validator: (val) {
                          if (controller.tempFoodsChecklist.isEmpty) {
                            return "Makanan / Minuman tidak boleh kosong";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const FormLabel(
                            label: "Pembayaran Lunas",
                            isRequired: true,
                          ),
                          Obx(
                            () => Switch(
                              value: controller.isPaid.value,
                              activeColor: Colors.green,
                              onChanged: (bool value) {
                                controller.isPaid.value = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FormButton(
                            type: FormButtonType.warning,
                            onPressed: () {
                              controller.calculateTotalPrice();
                              Get.bottomSheet(
                                enableDrag: false,
                                Container(
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
                                              Icons.highlight_remove_outlined,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Ruangan",
                                                style:
                                                    AppTextStyle.mediumStyle),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Visibility(
                                              visible:
                                                  controller.tempRooms.isEmpty,
                                              child: Text(
                                                  "Pilih Ruangan Terlebih Dahulu",
                                                  style: AppTextStyle
                                                      .regularStyle),
                                            ),
                                            Visibility(
                                              visible: controller
                                                  .tempRooms.isNotEmpty,
                                              child: Column(
                                                children: controller.tempRooms
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
                                                style:
                                                    AppTextStyle.mediumStyle),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Visibility(
                                              visible: controller
                                                  .tempFoodsChecklist.isEmpty,
                                              child: Text(
                                                  "Pilih Makanan & Minuman Terlebih Dahulu",
                                                  style: AppTextStyle
                                                      .regularStyle),
                                            ),
                                            Visibility(
                                              visible: controller
                                                  .tempFoodsChecklist
                                                  .isNotEmpty,
                                              child: Column(
                                                children: controller
                                                    .tempFoodsChecklist
                                                    .map(
                                                      (e) => Container(
                                                        margin: const EdgeInsets
                                                            .only(bottom: 6.0),
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
                                                  controller.totalPrice.value
                                                      .formatCurrencyIDR(),
                                                  style:
                                                      AppTextStyle.mediumStyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "Tampilkan Rician",
                              style: AppTextStyle.mediumStyle.copyWith(
                                color: AppColors.kPrimaryGreen2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          FormButton(
                            onPressed: () => controller.onSubmit(),
                            child: Text(
                              "Simpan",
                              style: AppTextStyle.mediumStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
