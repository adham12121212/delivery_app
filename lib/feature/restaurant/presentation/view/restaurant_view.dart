import 'dart:ui';

import 'package:delivery_app/feature/restaurant/domain/restaurant_repo/restaurant_reop.dart';
import 'package:delivery_app/feature/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key, this.category});

  static const routeName = 'restaurant';
  final String? category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      RestaurantCubit(getIt.get<RestaurantRepo>())..getResturant(category: category),
      child: BlocListener<RestaurantCubit, RestaurantState>(
        listener: (context, state) {
          debugPrint("STATE => $state");
          if (state is SuccessResturant) {
            debugPrint("COUNT => ${state.resturant.length}");
          }
          if (state is ErrorResturant) {
            debugPrint("ERROR => ${state.message}");
          }
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColor.primaryColors,
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: const [0, 1],
              ),
            ),
            child: CustomScrollView(
              slivers: [
                // appBar
                SliverAppBar(
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
                        decoration: BoxDecoration(
                          color: AppColor.purdarkColor.withValues(alpha: 0.10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SafeArea(
                          bottom: false,
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(Icons.location_on,
                                      color: AppColor.whiteColor, size: 20.r),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      'مدينة نصر',
                                      style: AppTextStyle.bold16.copyWith(
                                        color: AppColor.whiteColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                height: 50.h,
                                decoration: BoxDecoration(
                                  color: AppColor.whiteColor
                                      .withValues(alpha: .15),
                                  borderRadius: BorderRadius.circular(14.r),
                                  border: Border.all(
                                    color: AppColor.whiteColor
                                        .withValues(alpha: .3),
                                    width: 2,
                                  ),
                                ),
                                child: TextFormField(
                                  textAlign: TextAlign.right,
                                  cursorColor: AppColor.whiteColor,
                                  style: AppTextStyle.regular16.copyWith(
                                    color: AppColor.whiteColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "ابحث عن وجبة",
                                    hintStyle: AppTextStyle.regular14.copyWith(
                                      color: AppColor.whiteColor
                                          .withValues(alpha: .6),
                                    ),
                                    prefixIcon: Icon(
                                      CupertinoIcons.search,
                                      color: AppColor.whiteColor
                                          .withValues(alpha: .7),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Title
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 16.h),
                      Text(
                        'أفضل المطاعم',
                        style: AppTextStyle.simeBold17.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ]),
                  ),
                ),

                // List / State
                BlocBuilder<RestaurantCubit, RestaurantState>(
                  builder: (context, state) {
                    if (state is LoadingResturant) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 170.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    }

                    if (state is SuccessResturant) {
                      final restaurants = state.resturant;
                      if (restaurants.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(top: 140.h),
                            child: Center(
                              child: Text(
                                'لا توجد مطاعم حالياً',
                                style: AppTextStyle.medium14.copyWith(
                                  color: AppColor.whiteColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              final restaurant = restaurants[index];

                              return
                              //restaurant card
                                Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Container(
                                  height: 90.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.r),
                                    color: AppColor.whiteColor
                                        .withValues(alpha: .10),
                                    border: Border.all(
                                      color: AppColor.whiteColor
                                          .withValues(alpha: .18),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(18.r),
                                          child: Image.network(
                                            restaurant.image,
                                            width: 90.w,
                                            fit: BoxFit.cover,
                                            // ✅ prevents item from disappearing if image is bad
                                            errorBuilder: (_, __, ___) =>
                                                Container(
                                                  width: 110.w,
                                                  height: 110.h,
                                                  alignment: Alignment.center,
                                                  color: Colors.white24,
                                                  child: Icon(
                                                    Icons.broken_image,
                                                    color: AppColor.whiteColor,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                            horizontal: 6.w,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                restaurant.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle.simeBold17
                                                    .copyWith(
                                                  color: AppColor.whiteColor,
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star_rounded,
                                                    color: Colors.amberAccent,
                                                  ),
                                                  Text(
                                                    '٤.٤ ',
                                                    style: AppTextStyle.medium14
                                                        .copyWith(
                                                      color:
                                                      AppColor.whiteColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    '.${restaurant.deliveryTime}. ',
                                                    style: AppTextStyle.medium14
                                                        .copyWith(
                                                      color:
                                                      AppColor.whiteColor,
                                                    ),
                                                  ),
                                                  Text(
                                                    restaurant.deliveryPrice,
                                                    style: AppTextStyle.medium14
                                                        .copyWith(
                                                      color:
                                                      AppColor.whiteColor,
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
                              );
                            },
                            childCount: restaurants.length,
                          ),
                        ),
                      );
                    }
                    if (state is ErrorResturant) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 170.h,
                          child: Center(
                            child: Text(
                              state.message,
                              style: AppTextStyle.medium14.copyWith(
                                color: AppColor.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter(
                      child: SizedBox.shrink(),
                    );
                  },
                ),
                // bottom space
                SliverToBoxAdapter(child: SizedBox(height: 120.h)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}