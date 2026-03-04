import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.image,
    required this.title,
    required this.deliveryTime,
    required this.deliveryPrice,
    required this.onTap,
    required this.rating,
    this.isLoading = false,
  });

  final String image;
  final String title;
  final String deliveryTime;
  final String deliveryPrice;
  final VoidCallback? onTap;
  final String rating;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      effect: const ShimmerEffect(
        duration: Duration(milliseconds: 1500),
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFF5F5F5),
      ),
      child: GestureDetector(
        onTap:
        isLoading ?
        null :
        onTap,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Container(
            height: 95.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color:
              isLoading ? Colors.grey.shade50 : AppColor.purdarkColor.withValues(alpha: .9),
              border:
              Border.all(
                color: isLoading ? Colors.grey.shade50 : AppColor.blackColor.withValues(alpha: .18),
                width: 1,
              ),
            ),
            child: Row(
              children: [

                /// IMAGE
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.r),
                    child: isLoading
                        ? Container(
                      width: 90.w,
                      height: double.infinity,
                      color: Colors.grey,
                    )
                        : Image.network(
                      image,
                      width: 90.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 90.w,
                        color: Colors.white24,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.broken_image,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),

                /// DETAILS
                Expanded(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// TITLE
                        isLoading
                            ? Container(
                          width: 140.w,
                          height: 16.h,
                          color: Colors.grey.shade50,
                        )
                            : Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.simeBold17.copyWith(
                            color: AppColor.whiteColor,
                          ),
                        ),

                        SizedBox(height: 10.h),

                        /// RATING
                        isLoading
                            ? Container(
                          width: 60.w,
                          height: 14.h,
                          color: Colors.grey.shade50,
                        )
                            : Row(
                          children: [
                            Text(
                              rating,
                              style: AppTextStyle.medium16.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.amberAccent,
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        /// DELIVERY INFO
                        isLoading
                            ? Container(
                          width: 100.w,
                          height: 14.h,
                          color: Colors.grey.shade50,
                        )
                            : Row(
                          children: [
                            Text(
                              deliveryTime,
                              style:
                              AppTextStyle.medium16.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              deliveryPrice,
                              style:
                              AppTextStyle.medium16.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}