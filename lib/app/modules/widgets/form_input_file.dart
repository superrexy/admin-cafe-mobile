import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import 'package:admin_cafe_mobile/app/common/values/app_colors.dart';
import 'package:admin_cafe_mobile/app/common/values/styles/app_text_style.dart';

class FormInputFile extends StatelessWidget {
  const FormInputFile({
    super.key,
    this.changeImage,
    this.valueImage,
    this.resetImage,
    required this.label,
    this.fromInternet = false,
    this.imageUrl,
  });
  final File? valueImage;
  final Function()? changeImage;
  final Function()? resetImage;
  final String label;
  final bool? fromInternet;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return valueImage != null || fromInternet == true
        ? Container(
            margin: const EdgeInsets.only(top: 6.0),
            width: Get.width,
            height: 200.0,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryGreen1,
              borderRadius: BorderRadius.circular(8.0),
              image: fromInternet == true
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(
                        imageUrl!,
                      ),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: FileImage(valueImage!),
                      fit: BoxFit.cover,
                    ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0.0,
                  right: 0.0,
                  child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: resetImage,
                        child: Row(
                          children: [
                            Text(
                              "Hapus Foto",
                              style: AppTextStyle.mediumStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: changeImage,
            child: Container(
              margin: const EdgeInsets.only(top: 6.0),
              width: Get.width,
              height: 200.0,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryGreen1,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_upload_outlined,
                      color: Colors.white,
                      size: 42.0,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      label,
                      style: AppTextStyle.mediumStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
