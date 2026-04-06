import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';
import '../../domain/repo_order/repo_order.dart';
import '../cubit/order_cubit.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  static const routeName = 'order';

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'طلباتي',
          style: AppTextStyle.bold19.copyWith(
            color: AppColor.accent,
          ),
        ),
      ),

      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          // 🔄 Loading
          if (state is LoadingOrder) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Error
          if (state is ErrorOrder) {
            return Center(child: Text(state.message));
          }

          // ✅ Loaded
          if (state is LoadedOrder) {
            if (state.order.isEmpty) {
              return const Center(child: Text('لا يوجد طلبات'));
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              itemCount: state.order.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final order = state.order[index];

                return
                  Container(
                  margin: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Row(
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: Image.network(
                            order.image,
                            width: 90.w,
                            height: 90.h,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text(
                                    order.name, // ✅ ديناميك
                                    style: AppTextStyle.simeBold17,
                                  ),

                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(
                                          alpha: .15),
                                      borderRadius: BorderRadius.circular(
                                          8.r),
                                    ),
                                    child: Text(
                                      order.status, // ✅ ديناميك
                                      style: AppTextStyle.regular12.copyWith(
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 8.h),

                              Text(
                                '${order.price.toStringAsFixed(0)} جنيه',
                                // ✅ ديناميك
                                style: AppTextStyle.bold16,
                              ),

                              SizedBox(height: 10.h),

                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'عرض التفاصيل',
                                    style: AppTextStyle.regular14.copyWith(
                                      color: AppColor.accent,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}