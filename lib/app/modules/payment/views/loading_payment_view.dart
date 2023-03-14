import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/modules/payment/controllers/loading_payment_controller.dart';

class LoadingPaymentView extends GetView<LoadingPaymentController> {
  const LoadingPaymentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        children: [
          const SizedBox(height: 100),
          const Center(
            child: Text(
              'Menunggu Pembayaran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),
          SvgPicture.asset(
            AppImages.logo,
            height: 60,
          ),
          const SizedBox(height: 100),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
