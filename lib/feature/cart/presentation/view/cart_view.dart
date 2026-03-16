import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../data/model/cart_item_model.dart';
import '../cubit/cart_cubit.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});
  static const routeName = 'cart';

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().listenCart();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          centerTitle: true,
          title: Text('السلة', style: AppTextStyle.bold19.copyWith(color: AppColor.accent)),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state)
                {
                  if (state is CartInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartLoaded) {
                    if (state.items.isEmpty) {
                      return const Center(child: Text('السلة فارغة'));
                    }
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      itemCount: state.items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (_, index) {
                        final item = state.items[index];
                        return
                          Container(
                          height: 100.h,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(18.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.accent.withOpacity(.08),
                                blurRadius: 12,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(18.r),
                                    bottomRight: Radius.circular(18.r)),
                                child: Image.network(item.image,
                                    width: 100.w, height: 100.h, fit: BoxFit.cover),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 120.w,
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                item.name,
                                                style: AppTextStyle.bold16.copyWith(color: AppColor.blackColor)),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.close_rounded, color: Colors.grey),
                                            onPressed: () => context.read<CartCubit>().removeItem(item.id),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${item.totalPrice.toStringAsFixed(0)} جنيه',
                                              style: AppTextStyle.bold16.copyWith(color: AppColor.accent)),
                                          Container(
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              color: AppColor.accent.withOpacity(.1),
                                              borderRadius: BorderRadius.circular(10.r),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.remove_rounded, size: 16),
                                                  onPressed: () {
                                                    if (item.quantity > 1) {
                                                      context
                                                          .read<CartCubit>()
                                                          .updateQuantity(item.id, item.quantity - 1);
                                                    }
                                                  },
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                                  child: Text(item.quantity.toString(),
                                                      style: AppTextStyle.bold16.copyWith(color: AppColor.accent)),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.add_rounded, size: 16),
                                                  onPressed: () => context
                                                      .read<CartCubit>()
                                                      .updateQuantity(item.id, item.quantity + 1),
                                                ),
                                              ],
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
                        );
                      },
                    );
                  } else if (state is CartError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(.07), blurRadius: 20, offset: const Offset(0, -4))],
                    ),
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('المجموع الجزئي', style: AppTextStyle.medium14.copyWith(color: Colors.grey)),
                            Text('${state.subtotal.toStringAsFixed(0)} جنيه',
                                style: AppTextStyle.medium14.copyWith(color: AppColor.blackColor)),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('رسوم التوصيل', style: AppTextStyle.medium14.copyWith(color: Colors.grey)),
                            Text('25 جنيه', style: AppTextStyle.medium14.copyWith(color: AppColor.blackColor)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: const Divider(height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('الإجمالي', style: AppTextStyle.bold16.copyWith(color: AppColor.blackColor)),
                            Text('${state.total.toStringAsFixed(0)} جنيه',
                                style: AppTextStyle.bold19.copyWith(color: AppColor.accent)),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: double.infinity,
                          height: 54.h,
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.accent,
                              foregroundColor: AppColor.whiteColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                            ),
                            child: Text('تأكيد الطلب',
                                style: AppTextStyle.bold16.copyWith(color: AppColor.whiteColor)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(height: 60.h)
          ],
        ),
      ),
    );
  }
}