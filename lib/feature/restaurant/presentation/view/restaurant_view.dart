import 'dart:ui';

import 'package:delivery_app/feature/menu/presentation/view/menu_view.dart';
import 'package:delivery_app/feature/restaurant/presentation/cubit/restaurant_cubit.dart';
import 'package:delivery_app/feature/restaurant/presentation/widgets/restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/widgets/current_location.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../widgets/home_app_bar.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key, this.category});

  final String? category;
  static const routeName = 'restaurant';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = getIt<RestaurantCubit>();
        cubit.getResturant(category: category);
        return cubit;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                HomeAppBar(),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 16.h),
                      Text(
                        'أفضل المطاعم',
                        style: AppTextStyle.simeBold17.copyWith(
                          color: AppColor.purdarkColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ]),
                  ),
                ),
                BlocBuilder<RestaurantCubit, RestaurantState>(
                  builder: (context, state) {
                    if (state is LoadingResturant) {
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return RestaurantCard(
                                image: '',
                                title: '',
                                deliveryTime: '',
                                deliveryPrice: '',
                                rating: '',
                                isLoading: true,
                                onTap: null,
                              );
                            },
                            childCount: 6,
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
                                  color: AppColor.purdarkColor,
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

                              return RestaurantCard(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MenuView.routeName,
                                    arguments: {
                                      'id': restaurant.id,
                                      'title': restaurant.title,
                                      'image': restaurant.image,
                                      'rating': restaurant.rating,
                                    },
                                  );
                                },
                                image: restaurant.image,
                                title: restaurant.title,
                                deliveryTime: restaurant.deliveryTime,
                                deliveryPrice: restaurant.deliveryPrice,
                                rating: restaurant.rating,
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

                SliverToBoxAdapter(
                  child: SizedBox(height: 120.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

