import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/constant/app_text_style.dart';


class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    required this.controller,
    this.isPassword =true, required this.keyboardType, this.validator,});

  final String title;
  final  TextEditingController controller;
  final bool isPassword ;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

 bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.h,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColor.greyColor),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Text(
             widget.title,
              style: AppTextStyle.regular14.copyWith(
                color: AppColor.greyColor,
              ),
            ),
          ),
          TextFormField(
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword? obscureText :false,
            controller:widget.controller ,
            cursorColor: Colors.black,
            cursorHeight: 15,
            textAlign: TextAlign.right,
            style: AppTextStyle.medium14,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 30),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: Visibility(
                 visible: widget.isPassword,
                child:IconButton(onPressed: (){
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                    icon:
                obscureText ?Icon(
                  CupertinoIcons.eye_slash_fill,
                color: AppColor.grey2Color,):
                Icon(CupertinoIcons.eye_solid,
                color: AppColor.grey2Color,)

                ) ),
          )
        ],
      ),
    );
  }
}
