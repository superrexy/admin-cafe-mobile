import 'package:flutter/material.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/app_images.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onTap,
    this.isVisible = true,
  });
  final String imagePath;
  final String title;
  final Function() onTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kGray2, width: 2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: AppTextStyle.body
                    .copyWith(fontSize: 16, color: AppColors.kPrimaryGreen2),
              )
            ],
          ),
        ),
      ),
    );
  }
}
