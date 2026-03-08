
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/widgets/current_location.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../cubit/restaurant_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 110.h,
      collapsedHeight: 110.h,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  SizedBox(height: 8.h),
                  const CurrentLocation(),
                  SizedBox(height: 20.h),
                  Row(
                    children: [

                      GestureDetector(
                        onTap: () =>
                            Navigator.pop(context),
                        child:  Icon(
                          Icons.arrow_back,
                          size: 25,
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: Builder(
                          builder: (context) {
                            return CustomSearchBar(
                              color: AppColor.accent
                                  .withOpacity(.9),
                              onChanged: (value) {
                                context
                                    .read<RestaurantCubit>()
                                    .filterBySearch(value);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}