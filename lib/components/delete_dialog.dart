import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

deleteDialog(
    {required BuildContext context,
    required VoidCallback yesPress,
    required String title,
    subTitle}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: CustomText(
          text: title,
          color: ColorManager.black,
          fontSize: 25.sp,
          fontWeight: FontWeight.w500,
        ),
        content: CustomText(
          text: subTitle,
          color: ColorManager.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomText(
                text: "كلا",
                color: ColorManager.mainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          TextButton(
            onPressed: yesPress,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomText(
                text: "نعم",
                color: ColorManager.mainColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
