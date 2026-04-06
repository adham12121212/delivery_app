
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_text_style.dart';
import '../view/menu_view.dart';

class RestaurantMenuHeader extends StatelessWidget {
  const RestaurantMenuHeader({
    super.key,
    required this.widget,
  });

  final MenuView widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.restaurantImage,
            height: 100.h,
            width: 100.w,
            fit: BoxFit.cover,
          ),
        ),
         SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.restaurantTitle,
                style: AppTextStyle.bold19,
              ),
               SizedBox(height: 20.w),
              Row(
                children: [
                  Text(
                    widget.restaurantRating,
                    style: AppTextStyle.medium16,
                  ),
                  const Icon(
                    Icons.star_rounded,
                    color: Colors.amber,
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}