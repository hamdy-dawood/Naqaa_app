import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';

Decoration containerDecoration({required Color borderColor}) {
  return BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(10.r),
    border: Border.all(
      color: borderColor,
    ),
    boxShadow: [
      BoxShadow(
        color: ColorManager.darkGrey,
        blurRadius: 5.0,
        spreadRadius: 1.0,
      ),
    ],
  );
}
