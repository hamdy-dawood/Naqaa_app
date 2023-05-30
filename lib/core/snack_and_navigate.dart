import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void navigateTo({required Widget page, bool withHistory = true}) {
  if (withHistory) {
    Navigator.pushAndRemoveUntil(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => page),
      (route) => withHistory,
    );
  } else {
    Navigator.pushReplacement(
      navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}

showMessage({required String message, int maxLines = 1, double height = 30}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      backgroundColor: ColorManager.mainColor,
      elevation: 2.0,
      content: SizedBox(
        height: height,
        child: Row(
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: ColorManager.white,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: 16.sp,
                ),
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
