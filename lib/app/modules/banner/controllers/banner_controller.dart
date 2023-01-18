import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/api_client.dart';
import '../../../data/banner_provider.dart';
import '../../../model/response/banner_response.dart';

class BannerController extends GetxController {
  final BannerProvider _bannerProvider = BannerProvider(ApiClient.init());

  final bannersData = <BannerData>[].obs;

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

  Future<void> deleteBannerData(int bannerId) async {
    try {
      final response = await _bannerProvider.deleteBanner(bannerId);
      if (response) {
        await getBannersData();
        Get.snackbar(
          "Berhasil",
          "Banner berhasil dihapus",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getBannersData();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
