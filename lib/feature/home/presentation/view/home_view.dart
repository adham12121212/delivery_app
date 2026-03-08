import 'dart:ui';
import 'package:delivery_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/widgets/current_location.dart';
import '../../../../core/widgets/custom_search_bar.dart';
import '../../domain/home_repo/home_repo.dart';
import '../widgets/category_list.dart';
import '../widgets/offers_carousel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
  create: (context) => HomeCubit(
    getIt.get<HomeRepo>(),
  )..getOffers(),
  child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: CustomScrollView(
            slivers: [
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        SizedBox(height: 8.h),
                        // ===== Location row =====
                        CurrentLocation(),
                        SizedBox(height: 20.h),
                        // ===== Search =====
                        CustomSearchBar(color: AppColor.accent.withOpacity(.7)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
              SliverToBoxAdapter(
                 child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child:
                   Column(
                     children: [
                       SizedBox(height: 20.h),
                       Row(
                         children: [
                           Text(
                             'الأصناف',
                             style: AppTextStyle.simeBold17.copyWith(
                               color: AppColor.accent,
                             ),
                           ),
                           const Spacer(),
                           Text(
                             'عرض الكل',
                             style: AppTextStyle.regular14.copyWith(
                               color:
                               AppColor.accent.withValues(alpha: .5),
                             ),
                           ),
                         ],
                       ),
                       SizedBox(height: 10.h),
                       SizedBox(
                           height: 100.h,
                           child: CategoriesList()
                       ),
                     ],
                   ),
                 ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      OffersCarousel(),
                      SizedBox(height: 16.h),
                      Text('أفضل المطاعم',style: AppTextStyle.simeBold17.copyWith(
                        color: AppColor.accent
                      ),),
                      SizedBox(height:120,),
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








