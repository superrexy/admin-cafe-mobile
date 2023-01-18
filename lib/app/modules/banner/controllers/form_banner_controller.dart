import 'dart:io';

import 'package:admin_cafe_mobile/app/data/banner_provider.dart';
import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/model/request/banner_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'banner_controller.dart';

class FormBannerController extends GetxController {
  // BANNER CONTROLLER
  final BannerController bannerController = Get.find();

  // API SERVICE
  final BannerProvider _bannerProvider = BannerProvider(ApiClient.init());

  // Form Update
  bool isUpdate = false;
  bool isImageFromInternet = false;
  String? imageUrl;

  // Image Picker
  File? image;
  final ImagePicker picker = ImagePicker();

  Future<void> getImage() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 30);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    } else {
      print('No image selected.');
    }
  }

  Future<void> resetImage() async {
    isImageFromInternet = false;
    imageUrl = null;
    image = null;
    update();
  }

  Future<void> onSubmit() async {
    try {
      if (image == null) {
        Get.snackbar(
          "Gagal",
          "Foto banner tidak boleh kosong",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (isUpdate) {
        final response = await _bannerProvider.updateBanner(
            Get.arguments?['bannerId'], BannerRequest(image: image));

        if (response) {
          await bannerController.getBannersData();
          Get.back();
          Get.snackbar(
            "Berhasil",
            "Banner berhasil diubah",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Gagal",
            "Banner gagal diubah",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        final response =
            await _bannerProvider.createBanner(BannerRequest(image: image));

        if (response) {
          await bannerController.getBannersData();
          Get.back();
          Get.snackbar(
            "Berhasil",
            "Banner berhasil ditambahkan",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            "Gagal",
            "Banner gagal ditambahkan",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.printError(info: e.toString());
      Get.snackbar(
        "Terdapat Kesalahan",
        "Something went wrong",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getFoodnDrink(int bannerId) async {
    try {
      final res = await _bannerProvider.getBannerByID(bannerId);
      if (res != null) {
        imageUrl = res.image;
        update();
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      isUpdate = true;
      isImageFromInternet = true;
      getFoodnDrink(Get.arguments['food_id']);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
