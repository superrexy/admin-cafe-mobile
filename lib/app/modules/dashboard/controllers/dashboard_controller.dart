import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/banner_provider.dart';
import 'package:admin_cafe_mobile/app/data/booking_provider.dart';
import 'package:admin_cafe_mobile/app/data/dashboard_provider.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/response/banner_response.dart';
import 'package:admin_cafe_mobile/app/model/response/booking_response.dart';
import 'package:admin_cafe_mobile/app/model/response/dashboard_response.dart';
import 'package:admin_cafe_mobile/app/model/response/profile_response.dart';

class DashboardController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());
  final DashboardProvider _dashboardProvider =
      DashboardProvider(ApiClient.init());
  final BookingProvider _bookingProvider = BookingProvider(ApiClient.init());
  final BannerProvider _bannerProvider = BannerProvider(ApiClient.init());

  final selectedDate = DateTime.now().obs;
  final DateTime firstDate = DateTime.now().subtract(const Duration(days: 45));
  final DateTime lastDate = DateTime.now().add(const Duration(days: 45));

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final userProfile = ProfileData().obs;

  final statisticData =
      DashboardData(pegawaiCount: 0, roomCount: 0, bookingCount: 0).obs;

  final bookingData = <BookingData>[].obs;

  final bannersData = <BannerData>[].obs;

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  Future<ProfileResponse?> getProfileUser() async {
    try {
      final res = await _authenticationProvider.profileUser();

      if (res != null) {
        userProfile.update((val) {
          val!.id = res.data?.id;
          val.firstName = res.data?.firstName;
          val.lastName = res.data?.lastName;
          val.email = res.data?.email;
          val.phoneNumber = res.data?.phoneNumber;
          val.address = res.data?.address;
          val.imageProfile = res.data?.imageProfile;
          val.birthDate = res.data?.birthDate;
          val.role = res.data?.role;
          val.createdAt = res.data?.createdAt;
          val.updatedAt = res.data?.updatedAt;
        });

        return res;
      }

      return null;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getStaticticDashboard() async {
    try {
      final response = await _dashboardProvider.getDashboard();
      if (response != null) {
        statisticData.update((val) {
          val!.pegawaiCount = response.data.pegawaiCount;
          val.roomCount = response.data.roomCount;
          val.bookingCount = response.data.bookingCount;
        });
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  Future<void> getBookingsByDateData() async {
    try {
      final response =
          await _bookingProvider.getBookingsByDate(selectedDate.value.toUtc());
      if (response != null) {
        bookingData.assignAll(response);
      } else {
        bookingData.clear();
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  Future<void> getBookingsData() async {
    try {
      final response = await _bookingProvider.getBookings();
      if (response != null) {
        bookingData.assignAll(response);
      } else {
        bookingData.clear();
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  Future<void> getBannersData() async {
    try {
      final response = await _bannerProvider.getBanners();
      if (response != null) {
        bannersData.assignAll(response);
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  DateTime? findDateBookingNearNow() {
    try {
      final booking = bookingData.firstWhere(
        (element) =>
            element.tglPemesanan!.toLocal().isAfter(DateTime.now().subtract(
                  const Duration(days: 1),
                )) &&
            element.tglPemesanan!.toLocal().isBefore(
                  DateTime.now().add(
                    const Duration(days: 1),
                  ),
                ) &&
            element.isPaid == "SETTLEMENT" &&
            element.isFinished == false,
      );

      return booking.tglPemesanan;
    } catch (e) {
      Get.printError(info: e.toString());
    }
    return null;
  }

  Future<void> getAllData() async {
    getProfileUser();
    await getBannersData();
    await getStaticticDashboard();
    await getBookingsData();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getAllData().then((value) => print(findDateBookingNearNow()));
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
