import 'package:get/get.dart';

import '../controllers/image_profile_controller.dart';

class ImageProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageProfileController>(
      () => ImageProfileController(),
    );
  }
}
