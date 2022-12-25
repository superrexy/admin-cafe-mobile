import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  Future<void> redirectPage() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = Storage.hasData(Constants.token);
    if (token) {
      Get.offNamed(Routes.DASHBOARD);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }

  @override
  void onInit() {
    super.onInit();
    redirectPage();
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
