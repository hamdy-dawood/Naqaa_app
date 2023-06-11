import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';

class CardTypeItem extends StatelessWidget {
  const CardTypeItem({
    Key? key,
    required this.itemPress,
    required this.title,
    this.subTitle = "",
    required this.image,
    this.haveSub = true,
    required this.continuePress,
    required this.isSelected,
  }) : super(key: key);
  final VoidCallback itemPress, continuePress;
  final String title, subTitle, image;
  final bool haveSub, isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorManager.greyColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: isSelected
                  ? ColorManager.mainColor
                  : ColorManager.border2Color,
              width: 1.3),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55.r,
              backgroundColor: ColorManager.white,
              child: SvgIcon(
                icon: image,
                color: isSelected
                    ? ColorManager.mainColor
                    : ColorManager.borderColor,
                height: 60.h,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgIcon(
                  icon: isSelected
                      ? AssetsStrings.tickIcon
                      : AssetsStrings.tickUnFillIcon,
                  color: isSelected
                      ? ColorManager.mainColor
                      : ColorManager.borderColor,
                  height: 20.h,
                ),
                SizedBox(width: 12.w),
                CustomText(
                  text: title,
                  color: ColorManager.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            haveSub
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CustomText(
                      text: subTitle,
                      color: ColorManager.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal,
                      maxLines: 2,
                    ),
                  )
                : SizedBox(
                    height: 10.h,
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.16.sw),
              child: CustomElevated(
                text: "continue".tr,
                press: isSelected ? continuePress : () {},
                btnColor: ColorManager.white,
                textColor: isSelected
                    ? ColorManager.mainColor
                    : ColorManager.borderColor,
                fontSize: 16.sp,
                borderRadius: 8.r,
                borderColor: isSelected
                    ? ColorManager.mainColor
                    : ColorManager.borderColor,
                paddingHorizontal: 20.w,
                paddingVertical: 5.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
