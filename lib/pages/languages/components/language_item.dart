import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    Key? key,
    required this.itemPress,
    required this.title,
    required this.image,
    required this.isSelected,
  }) : super(key: key);
  final VoidCallback itemPress;
  final String title, image;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: isSelected
                  ? ColorManager.mainColor
                  : ColorManager.border2Color,
              width: 1.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgIcon(
              icon: isSelected
                  ? AssetsStrings.tickIcon
                  : AssetsStrings.tickUnFillIcon,
              color: isSelected
                  ? ColorManager.mainColor
                  : ColorManager.borderColor,
              height: 18.h,
            ),
            CustomText(
              text: title,
              color: ColorManager.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 25.h,
              child: Image.asset(image),
            ),
          ],
        ),
      ),
    );
  }
}
