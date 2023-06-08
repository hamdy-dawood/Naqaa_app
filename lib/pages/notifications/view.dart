import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 1.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 22.sp,
            color: ColorManager.black,
          ),
        ),
        title: CustomText(
          text: "notifications".tr,
          color: ColorManager.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: CustomText(
            text: "no_notifications".tr,
            color: ColorManager.mainColor,
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
