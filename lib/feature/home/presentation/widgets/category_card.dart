
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String emoji;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color: isSelected
                  ? AppColor.purdarkColor.withValues(alpha: .9)
                  : AppColor.greyColor.withValues(alpha: .1),
              border: Border.all(
                color: AppColor.whiteColor.withValues(alpha: .18),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: 32.sp),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title,
          style: AppTextStyle.regular14.copyWith(
            color: AppColor.purdarkColor,
          ),
        ),
      ],
    );
  }
}
