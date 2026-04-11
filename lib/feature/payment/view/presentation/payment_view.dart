import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';


class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  static const String routeName = "payment";

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  bool isHidden = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'طرق الدفع',
          style: AppTextStyle.bold19.copyWith(
            color: AppColor.accent,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              height: 90.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColor.accent,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'الحسابي الان',
                        style: AppTextStyle.medium18.copyWith(
                          color: AppColor.whiteColor,
                        ),
                      ),
                      IconButton(
                          onPressed: (){
                           setState(() {
                             isHidden = !isHidden;
                           });
                      },
                          icon:
                          Icon(
                           isHidden? CupertinoIcons.eye_slash_fill : Icons.remove_red_eye,color: Colors.white,))
                    ],
                  ),
                 SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child: Padding(
                                padding: EdgeInsets.only(right: 4.w),
                                child: Text(
                                  'جنيه',
                                  style: AppTextStyle.medium16.copyWith(
                                    color: AppColor.whiteColor.withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.baseline,
                              baseline: TextBaseline.alphabetic,
                              child:
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) =>
                                    FadeTransition(opacity: animation, child: child),
                                child: isHidden
                                    ? Container(
                                  key: const ValueKey('hidden'),
                                  width: 80.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                )
                                    : Text(
                                  '2000',
                                  key: const ValueKey('visible'),
                                  style: AppTextStyle.bold24.copyWith(
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child:  Center(
                          child: Text('إضافة',style:
                          AppTextStyle.medium16.copyWith(
                            color: AppColor.accent,
                          ),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h,),
            Text('إضافة بطاقه',style: AppTextStyle.medium18.copyWith(
              color: AppColor.accent,
            ),),
            SizedBox(height: 20.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: AppColor.accent.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child:
                  Column(
                    children: [
                     Image.asset('assets/logo/visa.png',width: 70.h,height: 70.h,),
                      Text('....AdhamMoham',style: AppTextStyle.simeBold17.copyWith(
                        color: AppColor.whiteColor,
                      ),),
                      SizedBox(height: 8.h,),
                      Text('4545••••••••••••',style: AppTextStyle.simeBold17.copyWith(
                        color: AppColor.whiteColor,
                      ),),
                      Text('20/35',style: AppTextStyle.simeBold17.copyWith(
                        color: AppColor.whiteColor,
                      ),),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all( 30.h),
                  width: MediaQuery.of(context).size.width/2.w,
                  height: 150.h,
                  decoration: BoxDecoration(
                    color: AppColor.accent.withValues(alpha: .4),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child:
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.whiteColor,
                    ),
                    child:  Icon(Icons.add,
                    size: 30.h,color: AppColor.accent.withValues(alpha: .4),
                    ),
                  )
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
