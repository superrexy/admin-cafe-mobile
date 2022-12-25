import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/data/foodndrink_provider.dart';
import 'package:admin_cafe_mobile/app/model/request/foodndrink_request.dart';
import 'package:admin_cafe_mobile/app/modules/foodndrink/controllers/foodndrink_controller.dart';

class FormFoodndrinkController extends GetxController {
  // API SERVICE
  final FoodnDrinkProvier _foodnDrinkProvier =
      FoodnDrinkProvier(ApiClient.init());

  // Room Controller
  final FoodndrinkController foodndrinkController = Get.find();

  // Form
  final GlobalKey<FormState> foodFormKey = GlobalKey<FormState>();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController foodPriceController = TextEditingController();
  final TextEditingController foodDescController = TextEditingController();

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
    if (foodFormKey.currentState!.validate()) {
      try {
        if (isUpdate) {
          final res = await _foodnDrinkProvier.updateFoodnDrink(
            FoodnDrinkRequest(
              nama: foodNameController.text,
              harga: foodPriceController.text,
              deskripsi: foodDescController.text,
              image: image,
            ),
            Get.arguments['food_id'],
          );
          if (res) {
            Get.back();
            Get.snackbar("Berhasil", "Berhasil Menambahkan Makanan / Minuman",
                backgroundColor: Colors.green, colorText: Colors.white);
            foodndrinkController.getFoodsnDrinks();
          }
        } else {
          final res = await _foodnDrinkProvier.createFoodnDrink(
            FoodnDrinkRequest(
              nama: foodNameController.text,
              harga: foodPriceController.text,
              deskripsi: foodDescController.text,
              image: image,
            ),
          );
          if (res) {
            Get.back();
            Get.snackbar("Berhasil", "Berhasil Menambahkan Makanan / Minuman",
                backgroundColor: Colors.green, colorText: Colors.white);
            foodndrinkController.getFoodsnDrinks();
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
  }

  Future<void> getFoodnDrink(int foodId) async {
    try {
      final res = await _foodnDrinkProvier.getFoodnDrinkByID(foodId);
      if (res != null) {
        foodNameController.text = res.nama;
        foodPriceController.text = res.harga.toString();
        foodDescController.text = res.deskripsi;
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
