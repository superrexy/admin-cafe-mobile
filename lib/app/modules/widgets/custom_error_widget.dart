import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/strings.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;

  const CustomErrorWidget({
    Key? key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          message ?? Strings.somethingWentWrong,
          style: Get.textTheme.headline5,
        ),
      ),
    );
  }
}
