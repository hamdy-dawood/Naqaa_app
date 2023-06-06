import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class BottomBarItem extends StatelessWidget {
  final String icon, label, selectedIcon;
  final VoidCallback onPress;
  final bool isSelected;

  const BottomBarItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPress,
    this.isSelected = true,
    required this.selectedIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            children: [
              Expanded(
                child: SvgPicture.asset(
                  isSelected ? selectedIcon : icon,
                  height: 22.h,
                ),
              ),
              SizedBox(height: 8.w),
              Expanded(
                child: CustomText(
                  text: label.tr,
                  color: ColorManager.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
