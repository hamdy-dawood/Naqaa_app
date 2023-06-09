import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/core/cache_helper.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.price,
      required this.image,
      required this.quantity,
      required this.addressType,
      required this.enTitle,
      required this.enSubTitle})
      : super(key: key);

  final String title,
      subTitle,
      enTitle,
      enSubTitle,
      price,
      image,
      quantity,
      addressType;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 80.h,
          width: 80.h,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Colors.black12,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Image.network(image),
          ),
        ),
        SizedBox(width: 10.h),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: CacheHelper.getLang() == "ar" ? title : enTitle,
                color: ColorManager.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                text: CacheHelper.getLang() == "ar" ? subTitle : enSubTitle,
                color: ColorManager.darkGrey,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  CustomText(
                    text: "${price} QR",
                    color: ColorManager.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomElevated(
                      text: "Qty $quantity",
                      press: () {},
                      btnColor: ColorManager.white,
                      textColor: ColorManager.mainColor,
                      fontSize: 15.sp,
                      paddingHorizontal: 10.w,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
