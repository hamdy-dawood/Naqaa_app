import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class CustomElevated extends StatelessWidget {
  final String text;
  final Color textColor, btnColor;
  final double fontSize, borderRadius, paddingVertical, paddingHorizontal;
  final VoidCallback press;

  const CustomElevated({
    Key? key,
    required this.text,
    required this.press,
    this.textColor = Colors.white,
    required this.btnColor,
    this.fontSize = 17,
    this.borderRadius = 5,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: press,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          side: BorderSide(
            color: ColorManager.mainColor,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHorizontal.w, vertical: paddingVertical.w),
          child: CustomText(
            text: text,
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
