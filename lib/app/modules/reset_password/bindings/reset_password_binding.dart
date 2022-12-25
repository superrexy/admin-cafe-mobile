import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/reset_password/controllers/change_password_reset_controller.dart';
import 'package:admin_cafe_mobile/app/modules/reset_password/controllers/verify_token_password_reset_controller.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordResetController>(
      () => ChangePasswordResetController(),
    );
    Get.lazyPut<VerifyTokenPasswordResetController>(
      () => VerifyTokenPasswordResetController(),
    );
    Get.lazyPut<ResetPasswordController>(
      () => ResetPasswordController(),
    );
  }
}
