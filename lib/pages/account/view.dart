import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqaa/components/custom_elevated_icon.dart';
import 'package:naqaa/components/custom_form_field.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/core/snack_and_navigate.dart';
import 'package:naqaa/pages/login/view.dart';

class MyAccountView extends StatelessWidget {
  const MyAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0.0,
        centerTitle: false,
        title: CustomText(
          text: "حسابي",
          color: ColorManager.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  SvgIcon(
                    height: 18.h,
                    icon: AssetsStrings.userEditIcon,
                    color: ColorManager.mainColor,
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: "تعديل بيانات الحساب",
                    color: ColorManager.mainColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          children: [
            Divider(
              color: ColorManager.mainColor,
              thickness: 0.5,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView(
                children: [
                  CustomText(
                    text: "الإسم",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextFormField(
                    controller: TextEditingController(),
                    hint: "الإسم",
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomText(
                    text: "رقم الجوال",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomTextFormField(
                    controller: TextEditingController(),
                    hint: "رقم الجوال",
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //todo change language
                  SizedBox(
                    height: 30.h,
                  ),
                  CustomElevatedWithIcon(
                    text: "تسجيل الخروج",
                    image: AssetsStrings.logoutIcon,
                    press: () {
                      navigateTo(page: const LoginView(), withHistory: false);
                      CacheHelper.removeUserID();
                    },
                    btnColor: ColorManager.mainColor,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomElevatedWithIcon(
                    text: "امسح حسابي",
                    image: AssetsStrings.deleteIcon,
                    press: () {},
                    textColor: ColorManager.mainColor,
                    btnColor: ColorManager.white,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Divider(
                    color: ColorManager.mainColor,
                    thickness: 0.5,
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "المساعدة",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsStrings.supportIcon,
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text: "support@naqaa.app",
                        color: ColorManager.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AssetsStrings.whatsappIcon,
                        height: 25.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        text: "+974 66877039",
                        color: ColorManager.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
