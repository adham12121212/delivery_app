import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.title,
    required this.desc,
    required this.buttonText,
    required this.imageUrl,
    this.onTap,
  });

  final String title;
  final String desc;
  final String buttonText;
  final String imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColor.purdarkColor.withValues(alpha: .9),
        border: Border.all(
          color: AppColor.purdarkColor.withValues(alpha: .18),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bold24.copyWith(
                    color: AppColor.whiteColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.regular14.copyWith(
                    color: AppColor.whiteColor.withValues(alpha: .70),
                  ),
                ),
                const Spacer(),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 10.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColor.whiteColor.withValues(alpha: .12),
                        border: Border.all(
                          color: AppColor.whiteColor.withValues(alpha: .22),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: AppTextStyle.medium14.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 14.w),
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.whiteColor.withValues(alpha: .10),
            ),
            child: ClipOval(
              child: imageUrl.isEmpty
                  ? const Icon(Icons.local_offer, color: Colors.white)
                  : Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.local_offer, color: Colors.white);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
