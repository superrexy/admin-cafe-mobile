import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/data/room_provider.dart';
import 'package:admin_cafe_mobile/app/model/request/room_request.dart';
import 'package:admin_cafe_mobile/app/modules/room/controllers/room_controller.dart';

class FormRoomController extends GetxController {
  // API SERVICE
  final RoomProvider _roomProvider = RoomProvider(ApiClient.init());

  // Room Controller
  final RoomController roomController = Get.find();

  // Form
  final GlobalKey<FormState> roomFormKey = GlobalKey<FormState>();
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController roomFacilityController = TextEditingController();
  final TextEditingController roomCapacityController = TextEditingController();
  final TextEditingController roomRentHourController = TextEditingController();
  final TextEditingController roomPriceController = TextEditingController();
  final TextEditingController roomQuotaController = TextEditingController();

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
      print(pickedFile.path);
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

  Future<void> createRoom() async {
    if (roomFormKey.currentState!.validate()) {
      try {
        if (isUpdate) {
          final res = await _roomProvider.updateRoom(
            RoomRequest(
              nama: roomNameController.text,
              fasilitas: roomFacilityController.text,
              kapasitas: roomCapacityController.text,
              waktu: roomRentHourController.text,
              harga: roomPriceController.text,
              quota: roomQuotaController.text,
              image: image,
            ),
            Get.arguments['room_id'],
          );

          if (res) {
            await roomController.getRooms();
            Get.back();
            Get.snackbar(
              "Berhasil",
              "Berhasil Memperbarui Ruangan",
            );
          }
        } else {
          final res = await _roomProvider.createRoom(
            RoomRequest(
              nama: roomNameController.text,
              fasilitas: roomFacilityController.text,
              kapasitas: roomCapacityController.text,
              waktu: roomRentHourController.text,
              harga: roomPriceController.text,
              quota: roomQuotaController.text,
              image: image,
            ),
          );

          if (res) {
            await roomController.getRooms();
            Get.back();
            Get.snackbar(
              "Berhasil",
              "Berhasil Menambahkan Ruangan",
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
  }

  Future<void> getRoom(int roomId) async {
    try {
      final res = await _roomProvider.getRoom(roomId);
      roomNameController.text = res!.nama;
      roomFacilityController.text = res.fasilitas;
      roomCapacityController.text = res.kapasitas;
      roomRentHourController.text = res.waktu;
      roomPriceController.text = res.harga.toString();
      roomQuotaController.text = res.quota.toString();
      imageUrl = res.image;
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      isUpdate = true;
      isImageFromInternet = true;
      getRoom(Get.arguments['room_id']);
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
