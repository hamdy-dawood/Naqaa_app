import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/svg_icons.dart';
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
        child: Column(
          children: [
            Expanded(
              child: SvgIcon(
                height: 22.h,
                icon: isSelected ? selectedIcon : icon,
                color: ColorManager.white,
              ),
            ),
            CustomText(
              text: label,
              color: ColorManager.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
