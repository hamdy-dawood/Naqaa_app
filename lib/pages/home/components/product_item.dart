import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.price,
      required this.image})
      : super(key: key);

  final String title, subTitle, price, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: ColorManager.mainColor,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.grey,
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 80.h,
            width: 80.h,
            margin: EdgeInsets.only(left: 12.w),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.black12,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  color: ColorManager.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: subTitle,
                  color: ColorManager.grey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: price,
                        color: ColorManager.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomElevated(
                        text: "إضافة",
                        press: () {},
                        btnColor: ColorManager.mainColor)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
