import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/widgets/awesome_snack_bar_content.dart';
import '../../../cart/data/model/cart_item_model.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../menu/data/model/menu_model.dart';
import '../../domain/details_repo/details_repo.dart';
import '../cubit/details_cubit.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.menu});
  final MenuModel menu;
  static const String routeName = 'details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailsCubit(
        menu.price,
      ),
      child: Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 260.h,
              pinned: true,
              backgroundColor: AppColor.whiteColor,
              leadingWidth: 70.w,
              scrolledUnderElevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
                  height: 45.h,
                  width: 45.h,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: AppColor.accent,
                  ),
                  child: Icon(Icons.arrow_back, size: 25, color: AppColor.whiteColor),
                ),
              ),
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
                        Text('${menu.price.toStringAsFixed(0)}  جنيه', style: AppTextStyle.bold16),
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
        bottomNavigationBar: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(20.r),
              decoration: const BoxDecoration(
                color: AppColor.whiteColor,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                children: [
                  // Quantity selector
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.greyColor),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            context.read<DetailsCubit>().decrement();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Text(
                            state.quantity.toString(),
                            key: ValueKey(state.quantity),
                            style: AppTextStyle.bold16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            context.read<DetailsCubit>().increment();
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),

                  // Add to cart button
                  Expanded(
                    child:
                    ElevatedButton(
                      onPressed: () async {
                        final detailsState = context.read<DetailsCubit>().state;
                        final cartCubit = context.read<CartCubit>();
                        final cartItem = CartItemModel(
                          id: menu.id,
                          name: menu.name,
                          image: menu.image,
                          price: menu.price,
                          quantity: detailsState.quantity,
                          totalPrice: detailsState.totalPrice,
                        );
                        await cartCubit.addItem(cartItem);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            behavior: SnackBarBehavior.floating,
                            content: AwesomeSnackBarContent(
                              title: 'تهانينا',
                              message: 'تمت الإضافة للسلة',
                              type: SnackType.success,
                            ),
                          ),
                        );
                      },
                    style: ElevatedButton.styleFrom(
                       backgroundColor: AppColor.accent,
                        foregroundColor: AppColor.whiteColor,
                        elevation: 0,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                      child: Text('أضف إلى السلة - ${state.totalPrice.toStringAsFixed(0)} جنيه'),
                    )
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