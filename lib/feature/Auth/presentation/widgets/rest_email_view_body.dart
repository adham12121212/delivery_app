import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../reset_cubit/reset_cubit.dart';
import '../views/login_view.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';
import 'gradient_button.dart';
import 'navigate_createlogin_email.dart';

class RestEmailViewBody extends StatefulWidget {
   RestEmailViewBody({super.key,required this.emailController});
  TextEditingController emailController =TextEditingController();


   @override
  State<RestEmailViewBody> createState() => _RestEmailViewBodyState();
}

class _RestEmailViewBodyState extends State<RestEmailViewBody> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.accent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80.0,right: 20,left: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios,
                  color: AppColor.whiteColor,),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 40.h,),
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
                      padding:  EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 35.h,),
                          SvgPicture.asset('assets/logo/restemaillogo.svg',color: AppColor.accent,),
                          SizedBox(height: 8.h,),
                          Text('استعادة كلمة المرور!',style: AppTextStyle.bold24,),
                          SizedBox(height: 8.h,),
                          Text('قم بادخال البريد الالكتروني لاستعادة كلمة المرور الخاصة بك!',
                            style: AppTextStyle.regular14.copyWith(
                                color: AppColor.greyColor
                            ),),
                          SizedBox(height: 40.h,),
                          CustomTextFormField(
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return 'من فضلك أدخل البريد الإلكتروني';
                              }
                              final emailRegex = RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              );
                              if (!emailRegex.hasMatch(value)) {
                                return 'بريد إلكتروني غير صحيح';
                              }
                              return null;
                            },
                            isPassword: false,
                            title: 'البريد الالكتروني',
                            controller: widget.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          SizedBox(height: 24.h,),

                          GradientButton(
                            text: "ارسال",
                            onTap: () {
                              final email = widget.emailController.text.trim();
                              context.read<ResetCubit>().sendResetLink(email);
                              print(widget.emailController.text);
                            }),
                          SizedBox(height: 230.h,),
                          NavigateCreateLoginEmail(
                            onTap: (){
                              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
                            },
                            title1: 'تذكرت كلمة المرور؟',
                            title2: 'تسجيل الدخول!',
                            color1: AppColor.blackColor,
                            color2: AppColor.blackColor,
                            containerColor: AppColor.purColor.withValues(alpha: .1),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
