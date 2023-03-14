import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/modules/payment/controllers/loading_payment_controller.dart';
import 'package:admin_cafe_mobile/app/modules/payment/controllers/payment_check_controller.dart';

import '../controllers/payment_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
      () => PaymentController(),
    );

    Get.lazyPut<LoadingPaymentController>(
      () => LoadingPaymentController(),
    );

    Get.lazyPut<PaymentCheckController>(
      () => PaymentCheckController(),
    );
  }
}
