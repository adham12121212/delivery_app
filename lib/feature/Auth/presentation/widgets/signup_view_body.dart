import 'package:delivery_app/feature/Auth/presentation/views/login_view.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../cubit/auth_cubit.dart';
import 'custom_button.dart';
import 'custom_divider.dart';
import 'custom_text_form_field.dart';
import 'navigate_createlogin_email.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  TextEditingController nameController =TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors:AppColor.primaryColors,
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0,100]

        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 50.h,),
          NavigateCreateLoginEmail(
            onTap: (){
              Navigator.of(context).pushReplacementNamed(LoginView.routeName);
            },
            title1: 'هل لديك حساب بالفعل؟',
            title2: 'تسجيل الدخول',
          ),
          SizedBox(height: 45.h,),
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
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 24.h,),
                      Text('سجّل الآن مجاناً!',style: AppTextStyle.bold24,),
                      SizedBox(height: 8.h,),
                      Text('ادخل البيانات التالية لانشاء حساب جديد، ابدء الان انه مجاني!',
                        style: AppTextStyle.regular14.copyWith(
                            color: AppColor.greyColor
                        ),),
                      SizedBox(height: 40.h,),
                      CustomTextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل الاسم الكامل';
                          }
                          return null;
                        },
                        isPassword: false,
                        title: 'الاسم الكامل',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: 12.h,),
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 12.h,),
                      CustomTextFormField(
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل كلمة المرور';
                          }
                          if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
                          }
                          return null;
                        },
                        isPassword: true,
                        title: 'كلمة المرور',
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                      ),

                      SizedBox(height: 24.h,),
                      CustomButton(
                        title: 'تسجيل مستخدم جديد',
                        onTap: (){
                        if(formKey.currentState!.validate()){
                          context.read<AuthCubit>().signUp(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                              nameController.text.trim()
                          );
                            }
                        },),
                      SizedBox(height: 10,),
                      Text(
                          'بالضغط على تسجيل مستخدم جديد، فانت توافق على سياسة الاستخدام والخصوصية!',
                          style: AppTextStyle.regular14.copyWith(
                              color: AppColor.blackColor
                          ),
                        ),
                      SizedBox(height: 60.h,),
                      CustomDivider(title: 'او تسجيل الدخول باستخدام',),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          SocialButtons(
                            onTap: (){
                              context.read<AuthCubit>().facebook();
                            },
                            title: 'Facebook',
                            image: 'assets/logo/facebook.svg',
                          ),
                          SizedBox(width: 28.w,),
                          SocialButtons(
                            onTap: (){
                              context.read<AuthCubit>().google();
                            },
                            title: 'Google',
                            image: 'assets/logo/google.svg',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
