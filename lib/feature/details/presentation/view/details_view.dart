
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../menu/data/model/menu_model.dart';
import '../cubit/details_cubit.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.menu});

  static const String routeName = 'details';
  final MenuModel menu;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(menu.price),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 260.h,
              pinned: true,
              backgroundColor: AppColor.whiteColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(menu.image, fit: BoxFit.cover),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(menu.name, style: AppTextStyle.bold19),
                        Text(
                            '${menu.price.toStringAsFixed(0)}  جنيه' ,
                            style: AppTextStyle.bold16),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text('الوصف:', style: AppTextStyle.medium16),
                    SizedBox(height: 4.h),
                    Text(
                      'تاكو طري محشو بالبيض المخفوق والجبن والإضافات.',
                      style: AppTextStyle.medium12.copyWith(color: AppColor.grey2Color),
                      textDirection: TextDirection.rtl,
                    ),
                    SizedBox(height: 120.h),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar:
        BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20.r),
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.read<DetailsCubit>().decrement(),
                          icon: const Icon(Icons.remove),
                        ),
                        Text(state.quantity.toString(), style: AppTextStyle.bold16),
                        IconButton(
                          onPressed: () => context.read<DetailsCubit>().increment(),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.accent,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        "أضف إلى السلة - ${state.totalPrice.toStringAsFixed(0)} جنيه",
                        style: AppTextStyle.bold16.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}