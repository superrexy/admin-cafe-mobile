import 'package:flutter/material.dart';

import 'package:date_time_picker/date_time_picker.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';

class FormInputDateTime extends StatelessWidget {
  const FormInputDateTime(
      {super.key,
      required this.hintText,
      this.controller,
      this.onChange,
      this.textInputAction,
      required this.initialDate});
  final TextEditingController? controller;
  final String hintText;
  final TextInputAction? textInputAction;
  final Function(String)? onChange;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      child: DateTimePicker(
        type: DateTimePickerType.date,
        controller: controller,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        textInputAction: textInputAction,
        initialDate: initialDate,
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kGray),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kPrimaryGreen1),
            borderRadius: BorderRadius.circular(6),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
