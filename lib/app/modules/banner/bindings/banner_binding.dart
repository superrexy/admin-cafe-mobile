import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/banner/controllers/form_banner_controller.dart';

import '../controllers/banner_controller.dart';

class BannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BannerController>(
      () => BannerController(),
    );
    Get.lazyPut<FormBannerController>(
      () => FormBannerController(),
    );
  }
}
