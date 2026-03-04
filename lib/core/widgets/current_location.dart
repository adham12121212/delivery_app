import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_color.dart';
import '../constant/app_text_style.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
            Icons.location_on,
            color: AppColor.purdarkColor,
            size: 20.r
        ),
        SizedBox(
            width: 6.w
        ),
        Expanded(
          child: Text(
            'مدينة نصر',
            style: AppTextStyle.bold16
                .copyWith(color: AppColor.purdarkColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
