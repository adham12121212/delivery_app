import 'package:delivery_app/feature/Auth/presentation/reset_cubit/reset_cubit.dart';
import 'package:delivery_app/feature/Auth/presentation/reset_cubit/reset_state.dart';
import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../../../core/di/get_it.dart';
import '../../domain/auth_repo/reset_repo.dart';
import '../widgets/custom_button.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  static const String routeName = 'successView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetCubit(
        getIt.get<ResetRepo>()
      ),
      child: Scaffold(
          body: BlocConsumer<ResetCubit, ResetState>(
            listener: (context, state) {
              if (state is PasswordChanged) {
                Navigator.pushReplacementNamed(context, SuccessView.routeName);
              }
              if (state is ResetError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColor.accent
                ),
                child: Column(
                  children: [
                    SizedBox(height: 120.h,),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.r),
                              topRight: Radius.circular(24.r),
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/logo/Vector.svg',
                              colorFilter:const ColorFilter.mode(
                                AppColor.accent,
                                BlendMode.srcIn,
                              ) ,
                              ),
                              SizedBox(height: 24.h,),
                              Text('تهانينا!', style: AppTextStyle.bold24,),
                              SizedBox(height: 8.h,),
                              Text(
                                'لقد تم تغيير كلمة مرور حسابك بنجاح، يمكنك الان العودة وتسجيل الدخول من جديد!',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.regular14.copyWith(
                                    color: AppColor.greyColor
                                ),),

                              SizedBox(height: 24.h,),
                              CustomButton(title: 'تسجيل الدخول',
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      LoginView.routeName);
                                },),
                              SizedBox(height: 16.h),
                              Text('تصفح سياسات الاستخدام والخصوصية',
                                style: AppTextStyle.regular14.copyWith(
                                    color: AppColor.blackColor
                                ),)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )
      ),
    );
  }
}
