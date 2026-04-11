import 'package:delivery_app/feature/Auth/data/model/user_model.dart';
import 'package:delivery_app/feature/Auth/domain/entity/user_entity.dart';
import 'package:delivery_app/feature/Auth/presentation/cubit/auth_cubit.dart';
import 'package:delivery_app/feature/favorite/presentation/view/favorite_view.dart';
import 'package:delivery_app/feature/location/presentation/cubit/location_cubit.dart';
import 'package:delivery_app/feature/order/presentation/view/order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../location/presentation/cubit/location_state.dart';
import '../../../payment/view/presentation/payment_view.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [

              SizedBox(height: 50.h),

              CircleAvatar(
                radius: 60.r,
                backgroundImage:
                const AssetImage('assets/image/adham.png'),
              ),

              SizedBox(height: 16.h),

              Text(
                user.name,
                style: AppTextStyle.medium16,
              ),

              SizedBox(height: 20.h),

              _infoCard(
                icon: Icons.email_outlined,
                title: "البريد الإلكتروني",
                value: user.email,
              ),

              SizedBox(height: 10.h),

              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  String locationText = "";

                  if (state is LocationFetchLoading) {
                    locationText = "جاري التحميل...";
                  } else if (state is LocationFetchSuccess) {
                    locationText = state.district!;
                  } else if (state is LocationFetchError) {
                    locationText = state.message;
                  } else {
                    locationText = "لم يتم تحديد الموقع بعد";
                  }

                  return _infoCard(
                    icon: Icons.location_on_outlined,
                    title: "الموقع",
                    value: locationText,
                  );
                },
              ),

              SizedBox(height: 30.h),

              _menuItem(
                icon: Icons.receipt_long_outlined,
                title: "طلباتي",
                onTap: (){
                  Navigator.pushNamed(context, OrderView.routeName);
                }
              ),

              _menuItem(
                icon: Icons.favorite_border,
                title: "المفضل",
                onTap: (){
                  Navigator.pushNamed(context, FavoriteView.routeName);

                }
              ),
              _menuItem(
                icon: Icons.payment_outlined,
                title: "طرق الدفع",
                onTap: (){
                  Navigator.pushNamed(context, PaymentView.routeName);
                }
              ),

              _menuItem(
                icon: Icons.settings_outlined,
                title: "الإعدادات",
                onTap: (){}
              ),

              SizedBox(height: 10.h),

              /// Logout Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().signOut();
                  },
                  child: Text(
                    "تسجيل الخروج",
                    style: AppTextStyle.bold16,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.accent,
                    foregroundColor: AppColor.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  /// Info Card
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [

          Icon(icon),

          SizedBox(width: 10.w),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.regular14),
              SizedBox(height: 4.h),
              Text(
                value, style: AppTextStyle.medium16,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Menu Item
  Widget _menuItem({
    required IconData icon,
    required String title,
    required Function() onTap
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title,),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}