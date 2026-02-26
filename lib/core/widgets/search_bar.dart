import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_color.dart';
import '../constant/app_text_style.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColor.whiteColor.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColor.whiteColor.withValues(alpha: .3),
          width: 2,
        ),
      ),
      child: TextFormField(
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
