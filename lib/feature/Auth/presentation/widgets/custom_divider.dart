import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_text_style.dart';
class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key, required this.title,
  });

  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        SizedBox(width: 8.w,),
        Text('او تسجيل الدخول باستخدام',
          style: AppTextStyle.regular12,),
        SizedBox(width: 8.w,),
        Expanded(child: Divider()),
      ],
    );
  }
}
