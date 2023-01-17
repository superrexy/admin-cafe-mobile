import 'package:admin_cafe_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/constants.dart';
import 'package:admin_cafe_mobile/app/common/storage/storage.dart';
import 'package:admin_cafe_mobile/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  // DASHBOARD CONTROLLER
  final DashboardController dashboardController = Get.find();

  Future<void> redirectPage() async {
    await Future.delayed(const Duration(seconds: 5));
    final token = Storage.hasData(Constants.token);
    if (token) {
      final response = await dashboardController.getProfileUser();

      if (response != null) {
        if (response.data?.role == 'admin') {
          Get.offNamed(Routes.DASHBOARD);
        } else {
          Get.offNamed(Routes.DASHBOARD_USER);
        }
      } else {
        Get.offNamed(Routes.LOGIN);
      }
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
