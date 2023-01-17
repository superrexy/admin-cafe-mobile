import 'package:flutter/material.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:admin_cafe_mobile/app/common/utils/extensions.dart';
import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';
import 'package:admin_cafe_mobile/app/modules/widgets/widgets.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        drawer: Sidebar(user: controller.userProfile.value),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Get.statusBarHeight * 0.5, left: 16.0, right: 16.0),
              color: AppColors.kPrimaryGreen3,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => controller.openDrawer(),
                            icon: const Icon(
                              Icons.menu,
                              color: AppColors.kPrimaryGreen1,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          SvgPicture.asset(
                            AppImages.logo,
                            width: 100,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.notifications_outlined),
                          const SizedBox(width: 12.0),
                          Obx(
                            () => GestureDetector(
                              onTap: () => Get.toNamed(Routes.PROFILE),
                              child:
                                  controller.userProfile.value.imageProfile ==
                                          null
                                      ? Image.asset(
                                          AppImages.imgUser,
                                          width: 45,
                                          height: 45,
                                        )
                                      : Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            image: DecorationImage(
                                              image: NetworkImage(controller
                                                  .userProfile
                                                  .value
                                                  .imageProfile!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Image.asset(AppImages.imgIceCream,
                            fit: BoxFit.cover, alignment: Alignment.center),
                      ),
                      Obx(
                        () => Flexible(
                          child: DayPicker.single(
                            selectedDate: controller.selectedDate.value,
                            onChanged: (value) {
                              controller.selectedDate.value = value;
                              controller.getBookingsByDateData();
                            },
                            firstDate: controller.firstDate,
                            lastDate: controller.lastDate,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.4,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: scrollController,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () => Text(
                                    "Rekap Data ${controller.selectedDate.value.day == DateTime.now().day ? "Hari Ini" : controller.selectedDate.value.formatDateToString("dd MMMM yyy")} !",
                                    style: AppTextStyle.boldStyle.copyWith(
                                        fontSize: 15,
                                        color: AppColors.kPrimaryGreen2),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.kGray2,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                                AppImages.icPegawai),
                                            const SizedBox(height: 10),
                                            FittedBox(
                                              child: Text(
                                                "${controller.statisticData.value.pegawaiCount} Pegawai",
                                                style: AppTextStyle.mediumStyle
                                                    .copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.kGray2,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              AppImages.icPelanggan2,
                                              width: 55,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(height: 10),
                                            FittedBox(
                                              child: Text(
                                                "${controller.statisticData.value.bookingCount} Pelanggan",
                                                style: AppTextStyle.mediumStyle
                                                    .copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 100,
                                        padding: const EdgeInsets.all(16.0),
                                        decoration: BoxDecoration(
                                          color: AppColors.kGray2,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              spreadRadius: 3,
                                              blurRadius: 10,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              AppImages.icRuangan,
                                              width: 40,
                                              fit: BoxFit.cover,
                                            ),
                                            const SizedBox(height: 10),
                                            FittedBox(
                                              child: Text(
                                                "${controller.statisticData.value.roomCount} Ruangan",
                                                style: AppTextStyle.mediumStyle
                                                    .copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Obx(
                                  () => Text(
                                    "Data Pelanggan ${controller.selectedDate.value.day == DateTime.now().day ? "Hari Ini" : controller.selectedDate.value.formatDateToString("dd MMMM yyy")} !",
                                    style: AppTextStyle.boldStyle.copyWith(
                                        fontSize: 15,
                                        color: AppColors.kPrimaryGreen2),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                SizedBox(
                                  width: Get.width,
                                  child: Obx(
                                    () => DataTable(
                                      headingRowColor:
                                          MaterialStateProperty.all(
                                              AppColors.kGray3),
                                      columns: const [
                                        DataColumn(
                                            label: Expanded(
                                          child: Text('Nama',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        )),
                                        DataColumn(
                                            label: Expanded(
                                          child: Text('Email',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        )),
                                        DataColumn(
                                            label: Expanded(
                                          child: Text('Waktu',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                        )),
                                      ],
                                      rows: controller.bookingData
                                          .map(
                                            (element) => DataRow(
                                              cells: [
                                                DataCell(Center(
                                                  child: FittedBox(
                                                    child: Text(
                                                      element.namaPemesan!,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Center(
                                                  child: SizedBox(
                                                    width: 100,
                                                    child: FittedBox(
                                                      child: Text(
                                                        element.emailPemesan!,
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(
                                                  Center(
                                                    child: FittedBox(
                                                      child: Text(
                                                        timeago.format(
                                                            element
                                                                .tglPemesanan!,
                                                            locale: 'id'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.bookingData.isEmpty,
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Text(
                                          "Data Pelanggan Kosong",
                                          style: AppTextStyle.mediumStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ));
              },
            )
          ],
        ));
  }
}
