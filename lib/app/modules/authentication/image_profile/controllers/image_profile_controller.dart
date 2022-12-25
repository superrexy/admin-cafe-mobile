import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:admin_cafe_mobile/app/data/data.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class ImageProfileController extends GetxController {
  // API CLIENT
  final AuthenticationProvider _authenticationProvider =
      AuthenticationProvider(ApiClient.init());

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
    image = null;
    update();
  }

  Future<void> uploadImageProfile() async {
    try {
      final res = await _authenticationProvider.uploadImageProfile(image!);
      if (res) {
        Get.snackbar(
          "Berhasil",
          "Berhasil mengubah foto profil",
        );

        Get.offAllNamed(Routes.DASHBOARD);
      }
    } catch (e) {
      print("ERROR");
      print(e);
      Get.snackbar(
        "Terdapat Kesalahan",
        "Something went wrong",
      );
    }
  }

  @override
  void onInit() {
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
