import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/payment/controllers/loading_payment_controller.dart';

class LoadingPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoadingPaymentController>(
      LoadingPaymentController(),
    );
  }
}
