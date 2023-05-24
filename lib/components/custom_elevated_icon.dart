import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class CustomElevatedWithIcon extends StatelessWidget {
  final String text, image;
  final Color textColor, btnColor;
  final double hSize, wSize, fontSize, borderRadius;
  final VoidCallback press;

  const CustomElevatedWithIcon({
    Key? key,
    required this.text,
    required this.image,
    required this.press,
    this.textColor = Colors.white,
    required this.btnColor,
    this.hSize = 50,
    this.wSize = 200,
    this.fontSize = 18,
    this.borderRadius = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SvgPicture.asset(
          image,
          height: 20.h,
        ),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        elevation: 0.0,
        fixedSize: Size(wSize, hSize.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
          side: BorderSide(
            color: ColorManager.mainColor,
          ),
        ),
      ),
      label: CustomText(
        text: text,
        color: textColor,
        fontWeight: FontWeight.normal,
        fontSize: fontSize.sp,
      ),
    );
  }
}
