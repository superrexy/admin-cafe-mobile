import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/data/foodndrink_provider.dart';
import 'package:admin_cafe_mobile/app/model/response/foodndrink_response.dart';
import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';

class FoodndrinkController extends GetxController {
  // FORM BOOKING CONTROLLER
  final FormBookingController formBookingController = Get.find();
  final DashboardController dashboardController = Get.find();

  // API CLIENT
  final FoodnDrinkProvier _foodnDrinkProvier =
      FoodnDrinkProvier(ApiClient.init());

  // OBSERVABLES
  final foodsnDrinks = <FoodnDrinkData>[].obs;
  final foodsnDrinksCopy = <FoodnDrinkData>[].obs;

  final orderItemSelected = "none".obs;
  var orderItems = [
    {
      "key": "Harga",
      "value": "none",
    },
    {
      "key": "Murah ke Mahal",
      "value": "asc",
    },
    {
      "key": "Mahal ke Murah",
      "value": "desc",
    },
  ];

  Future<void> sortingPrice(String type) async {
    if (orderItemSelected == "asc") {
      foodsnDrinks.sort((a, b) => a.harga.compareTo(b.harga));
    } else if (orderItemSelected == "desc") {
      foodsnDrinks.sort((a, b) => b.harga.compareTo(a.harga));
    } else {
      foodsnDrinks.assignAll(foodsnDrinksCopy);
    }
  }

  Future<void> searchRoom(String query) async {
    if (query.isEmpty) {
      foodsnDrinks.assignAll(foodsnDrinksCopy);
    } else {
      foodsnDrinks.assignAll(foodsnDrinksCopy
          .where((element) =>
              element.nama.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  void getFoodsnDrinks() async {
    try {
      final foods = await _foodnDrinkProvier.getFoodsnDrinks();

      if (foods.isNotEmpty) {
        foodsnDrinks.assignAll(foods);
        foodsnDrinksCopy.assignAll(foods);
      } else {
        foodsnDrinks.clear();
        foodsnDrinksCopy.clear();
      }

      if (Get.arguments?['isUpdateMenu']) {
        for (var element in formBookingController.tempFoodsChecklist) {
          foodsnDrinks.where((food) => food.id == element.id).forEach((food) {
            food.isChecked = true;
            food.quantity = element.quantity;
            food.note = element.note;
          });

          foodsnDrinksCopy
              .where((food) => food.id == element.id)
              .forEach((food) {
            food.isChecked = true;
            food.quantity = element.quantity;
            food.note = element.note;
          });
        }
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  void deleteFoodnDrink(FoodnDrinkData data) async {
    try {
      final res = await _foodnDrinkProvier.deleteFoodnDrink(data.id);

      if (res) {
        print(res);
        getFoodsnDrinks();
        Get.snackbar("Berhasil", "Berhasil Menghapus Data",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.printError(info: e.toString());
    }
  }

  // Food Cart Update Checked
  void updateCartChecked(FoodnDrinkData data) {
    data.isChecked = !data.isChecked!;
    foodsnDrinks.refresh();
  }

  // Food Cart Update Quantity
  void updateCartQuantity(FoodnDrinkData data, int value) {
    data.quantity = value;
    foodsnDrinks.refresh();
  }

  // Food Card Update Note
  void updateCartNote(FoodnDrinkData data, String value) {
    data.note = value;
  }

  // Add Food checked on Booking List
  void addFoodChecked() {
    formBookingController.tempFoodsChecklist.clear();
    formBookingController.tempFoodsChecklist.assignAll(
        foodsnDrinks.where((element) => element.isChecked == true).toList());
    Get.back();
  }

  @override
  void onInit() {
    getFoodsnDrinks();
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
