import 'package:delivery_app/feature/details/presentation/view/details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../data/model/menu_model.dart';

class BuildSection extends StatelessWidget {
  const BuildSection({
    super.key,
    required this.title,
    required this.items,
    this.isLoading = false,
  });

  final String title;
  final List<MenuModel> items;
  final bool isLoading;


  @override
  Widget build(BuildContext context) {

    final displayItems =
    isLoading ? List.generate(6, (index) => MenuModel(
      id: '',
      name: 'Loading',
      image: '',
      price: 0,
      menuCategory: '',
      isAvailable: true,
    )) : items;

    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      effect: const ShimmerEffect(
        duration: Duration(milliseconds: 1500),
        baseColor: Color(0xFFE0E0E0),
        highlightColor: Color(0xFFF5F5F5),
      ),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: AppTextStyle.bold19.copyWith(
                color: AppColor.accent,
              ),
            ),

             SizedBox(height: 10.h),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final item = displayItems[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      DetailsView.routeName,
                      arguments: item,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: AppColor.accent.withValues(alpha: .9),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius:  BorderRadius.only(
                            topLeft: Radius.circular(12.r),
                            topRight: Radius.circular(12.r),
                          ),
                          child: isLoading
                              ? Container(
                            height: 90.h,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                          )
                              : Image.network(
                            item.image,
                            height: 90.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) {
                              return Container(
                                height: 90.h,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.broken_image,
                                ),
                              );
                            },
                          ),
                        ),

                         SizedBox(height: 8.h),

                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Text(
                                  item.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.bold16.copyWith(
                                    color: AppColor.surface,
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),

                        const Spacer(),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               padding: EdgeInsets.all(8.w),
                               margin: EdgeInsets.symmetric(horizontal: 8.w),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(12.r),
                                 color: AppColor.surface,
                               ),
                               child: Text(
                                 '${item.price.toStringAsFixed(0)} جنيه' ,
                                 style: AppTextStyle.simeBold17.copyWith(
                                   color: AppColor.accent,
                                 ),
                               ),
                             ),
                             Padding(
                              padding:  EdgeInsets.all(8.w),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: GestureDetector(
                                  onTap: isLoading
                                      ? null
                                      : () {
                                    Navigator.pushNamed(
                                      context,
                                      DetailsView.routeName,
                                    );
                                  },
                                  child:
                                  isLoading
                                      ? Container(
                                    height: 30.h,
                                    width: 35.w,
                                    color: Colors.grey.shade300,
                                  ):
                                  Container(
                                    height: 30.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: AppColor.surface,
                                    ),
                                    child: Icon(
                                      Icons.open_in_full,
                                      color: AppColor.accent,
                                      size: 20.h,
                                    ),
                                  ),
                                ),
                              ),
                                                   ),
                           ],
                         ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}