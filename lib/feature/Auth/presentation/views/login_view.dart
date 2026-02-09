import 'package:flutter/material.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: AppColor.primaryColors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0,100
              ]

          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor.withValues(alpha: .10),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('سجل الآن!',style: AppTextStyle.medium14.copyWith(
                        color: AppColor.whiteColor
                    )),
                  ),
                  Text('ليس لديك حساب؟',style: AppTextStyle.medium14.copyWith(
                      color: AppColor.whiteColor
                  ),),

                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    )
                ),
                child: Column(
                  children: [
                    SizedBox(height: 24,),
                    Text('!أهلا بعودتك',style: AppTextStyle.bold24,),
                    SizedBox(height: 8,),
                    Text('!ادخل البيانات التالية لتتمكن من الوصول إلى حسابك',
                      style: AppTextStyle.regular14.copyWith(
                          color: AppColor.greyColor
                      ),),
                    SizedBox(height: 40,),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'البريد الالكتروني'

                      ),
                    )


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}