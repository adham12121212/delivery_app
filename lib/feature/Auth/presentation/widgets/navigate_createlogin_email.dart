import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class NavigateCreateLoginEmail extends StatelessWidget {
  const NavigateCreateLoginEmail({
    super.key, required this.title1, required this.title2, required this.onTap,
  });
  final String title1;
  final String title2;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.0.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title1,style: AppTextStyle.medium14.copyWith(
              color: AppColor.whiteColor
          ),),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColor.whiteColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(title2,style: AppTextStyle.medium14.copyWith(
                  color: AppColor.whiteColor
              )),
            ),
          ),

        ],
      ),
    );
  }
}
