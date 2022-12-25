import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key? key,
    this.keyboardType,
    this.textCapitalization,
    this.textInputAction,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.isTextArea = false,
    this.onTap,
    this.readOnly = false,
    this.onChanged,
    this.validator,
    this.contentPadding,
    this.maxLength,
  }) : super(key: key);
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final Icon? prefixIcon;
  final String hintText;
  final TextEditingController controller;
  final bool? isTextArea;
  final bool? readOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0),
      child: TextFormField(
        controller: controller,
        maxLines: isTextArea == true ? 5 : 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: keyboardType ?? TextInputType.text,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        textInputAction: textInputAction ?? TextInputAction.none,
        onTap: onTap,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        validator: validator,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kGray),
            borderRadius: BorderRadius.circular(6),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.kPrimaryGreen1),
            borderRadius: BorderRadius.circular(6),
          ),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
