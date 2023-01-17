import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/data/room_provider.dart';
import 'package:admin_cafe_mobile/app/model/response/room_response.dart';
import 'package:admin_cafe_mobile/app/modules/booking/controllers/form_booking_controller.dart';

// ignore_for_file: unrelated_type_equality_checks

class RoomController extends GetxController {
  // FORM BOOKING CONTROLLER
  final FormBookingController formBookingController = Get.find();
  final DashboardController dashboardController = Get.find();

  // OBSERVABLE
  final rooms = <RoomData>[].obs;
  final roomsCopy = <RoomData>[].obs;

  // API SERVICE
  final RoomProvider _roomProvider = RoomProvider(ApiClient.init());

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
      rooms.sort((a, b) => a.harga.compareTo(b.harga));
    } else if (orderItemSelected == "desc") {
      rooms.sort((a, b) => b.harga.compareTo(a.harga));
    } else {
      rooms.assignAll(roomsCopy);
    }
  }

  Future<void> searchRoom(String query) async {
    if (query.isEmpty) {
      rooms.assignAll(roomsCopy);
    } else {
      rooms.assignAll(roomsCopy
          .where((element) =>
              element.nama.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
  }

  Future<void> getRooms() async {
    try {
      final response = await _roomProvider.getRooms();
      if (response != null) {
        rooms.assignAll(response);
        roomsCopy.assignAll(response);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteRoom(int idRoom) async {
    try {
      final response = await _roomProvider.deleteRoom(idRoom);
      if (response) {
        getRooms();
        Get.snackbar("Berhasil", "Berhasil Menghapus Data",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    getRooms();
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
