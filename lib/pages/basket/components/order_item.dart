import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
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
      child: Column(
        children: [
          Row(
            children: [
              SvgIcon(
                height: 22.h,
                icon: "assets/icons/location.svg",
                color: ColorManager.black,
              ),
              SizedBox(
                width: 10.w,
              ),
              CustomText(
                text: "عنوان الطلب",
                color: ColorManager.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
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
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            text: title,
                            color: ColorManager.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: ColorManager.red,
                            size: 30.sp,
                          ),
                        ),
                      ],
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
                          text: "Qty 1",
                          press: () {},
                          btnColor: ColorManager.white,
                          textColor: ColorManager.mainColor,
                          fontSize: 15.sp,
                          paddingHorizontal: 10.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
