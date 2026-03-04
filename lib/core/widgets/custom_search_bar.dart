import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_color.dart';
import '../constant/app_text_style.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.color, this.onChanged});

  final Color? color;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: color ?? AppColor.whiteColor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColor.whiteColor.withValues(alpha: .3),
          width: 2,
        ),
      ),
      child: TextField(
        onChanged: onChanged,
        textAlign: TextAlign.right,
        cursorColor: AppColor.whiteColor,
        style: AppTextStyle.regular16
            .copyWith(color: AppColor.whiteColor),
        decoration: InputDecoration(
          hintText: "ابحث عن وجبة أو مطعم",
          hintStyle: AppTextStyle.regular14.copyWith(
            color: AppColor.whiteColor.withValues(alpha: .6),
          ),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: AppColor.whiteColor.withValues(alpha: .7),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        ),
      ),
    );
  }
}
