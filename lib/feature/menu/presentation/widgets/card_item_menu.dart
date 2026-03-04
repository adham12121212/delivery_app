import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class CardItemMenu extends StatefulWidget {
  final Function(int index) onCategorySelected;
  final List<String> menuCategory;

   CardItemMenu({
    super.key,
    required this.onCategorySelected,
    required this.menuCategory
  });

  @override
  State<CardItemMenu> createState() => _CardItemMenuState();
}

class _CardItemMenuState extends State<CardItemMenu> {


  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.menuCategory.length,
        separatorBuilder: (_, __) =>  SizedBox(width: 14.w),
        itemBuilder: (context, index) {
          final bool isActive = isSelected == index;

          return GestureDetector(
            onTap: () {
              setState(() => isSelected = index);
              widget.onCategorySelected(index);
              print(widget.onCategorySelected);
              print(widget.menuCategory);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding:
               EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColor.purdarkColor
                    : AppColor.whiteColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.purdarkColor,
                ),
              ),
              child: Center(
                child: Text(
                 widget.menuCategory[index],
                  style: AppTextStyle.medium16.copyWith(
                    color: isActive
                        ? AppColor.whiteColor
                        : AppColor.purdarkColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}