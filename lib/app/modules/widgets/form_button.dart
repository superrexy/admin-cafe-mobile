import 'package:flutter/material.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';

enum FormButtonType { primary, secondary, danger, warning }

class FormButton extends StatelessWidget {
  const FormButton(
      {super.key,
      required this.child,
      this.onPressed,
      this.type = FormButtonType.primary});
  final Widget child;
  final Function()? onPressed;
  final FormButtonType type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(type == FormButtonType.primary
                ? AppColors.kPrimaryGreen2
                : type == FormButtonType.secondary
                    ? AppColors.kPrimaryGreen1
                    : type == FormButtonType.danger
                        ? AppColors.kDanger
                        : AppColors.kWarning),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
        ),
      ),
      child: child,
    );
  }
}
