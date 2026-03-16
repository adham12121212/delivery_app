import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.title, required this.onTap,
  });

  final String title;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
          color: AppColor.accent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(title,
            style:AppTextStyle.bold16.copyWith(
                color: AppColor.whiteColor
            ) ,),
        ),
      ),
    );
  }
}
