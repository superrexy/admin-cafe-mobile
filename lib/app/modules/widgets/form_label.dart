import 'package:flutter/material.dart';

import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';

class FormLabel extends StatelessWidget {
  const FormLabel({super.key, required this.label, this.isRequired = false});
  final String label;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: AppTextStyle.mediumStyle
              .copyWith(fontSize: 14, color: Colors.black.withOpacity(0.75)),
        ),
        if (isRequired!)
          const Text(
            " *",
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
