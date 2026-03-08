import 'package:delivery_app/feature/Auth/presentation/views/rest_email_view.dart';
import 'package:delivery_app/feature/Auth/presentation/views/signup_view.dart';
import 'package:delivery_app/feature/Auth/presentation/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';
import '../../data/model/login_request_body.dart';
import '../cubit/auth_cubit.dart';
import '../rest_api_cubit/restapi_cubit.dart';
import 'custom_button.dart';
import 'custom_divider.dart';
import 'custom_text_form_field.dart';
import 'navigate_createlogin_email.dart';


class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50.h,),
        NavigateCreateLoginEmail(
          onTap: (){
            Navigator.of(context).pushReplacementNamed(SignupView.routeName);
          },
          title1: 'ليس لديك حساب؟',
          title2: 'سجل الآن!',
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
                    Text('!أهلا بعودتك',style: AppTextStyle.bold24,),
                    SizedBox(height: 8.h,),
                    Text('!ادخل البيانات التالية لتتمكن من الوصول إلى حسابك',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.of(context).pushNamed(RestEmailView.routeName);

                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              overlayColor: Colors.transparent,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.padded,
                            ),
                            child: Text(
                              'هل نسيت كلمة المرور؟',
                              style: AppTextStyle.medium12.copyWith(
                                  color: AppColor.blackColor
                              ),)),
                      ],
                    ),
                    SizedBox(height: 24.h,),
                    CustomButton(title: 'تسجيل الدخول!',
                      onTap:
                          (){

                      if (formKey.currentState!.validate()) {

                        context.read<AuthCubit>().login(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      }
                    },
                    ),
                    SizedBox(height: 125.h,),
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
    );
  }
}

