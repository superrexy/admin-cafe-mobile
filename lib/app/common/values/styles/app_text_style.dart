import 'package:flutter/material.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';

abstract class AppTextStyle {
  static final TextStyle heading1 = mediumStyle.copyWith(fontSize: 24);
  static final TextStyle heading2 = mediumStyle.copyWith(fontSize: 20);
  static final TextStyle body = regularStyle.copyWith(fontSize: 16);

  static final TextStyle lightStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w300,
  );

  static final TextStyle regularStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w400,
  );

  static final TextStyle mediumStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w500,
  );

  static final TextStyle semiBoldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w600,
  );

  static final TextStyle boldStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle buttonTextStyle = _textStyle.copyWith(
    fontWeight: FontWeight.w700,
  );

  static final TextStyle _textStyle = TextStyle(color: Colors.black);
}
