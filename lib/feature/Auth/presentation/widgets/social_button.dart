
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key, required this.title, required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: AppColor.grey2Color,
                width: 1
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: AppTextStyle.regular16.copyWith(
                color: AppColor.blackColor
            ),),
            SizedBox(width: 8.w,),
            SvgPicture.asset(image,width: 22.w,height: 22.h,),

          ],
        ),
      ),
    );
  }
}