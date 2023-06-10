import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/custom_form_field.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/add_all_basket_order/view.dart';

class ManualAddressView extends StatelessWidget {
  const ManualAddressView(
      {Key? key, required this.address, required this.lat, required this.long})
      : super(key: key);
  final String address, lat, long;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
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
      ),
      body: SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 10.h),
                CustomText(
                  text: "address_details".tr,
                  color: ColorManager.borderColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
                Divider(
                  color: ColorManager.mainColor,
                  thickness: 0.5,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    SvgIcon(
                      height: 22.h,
                      icon: AssetsStrings.locationIcon,
                      color: ColorManager.black,
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: CustomText(
                        text: "${address}",
                        color: ColorManager.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hint: "details1".tr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "details1_validate".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hint: "details2".tr,
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  controller: TextEditingController(),
                  hint: "details3".tr,
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  isLastInput: true,
                  controller: TextEditingController(),
                  hint: "details4".tr,
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomElevated(
                  text: "next".tr,
                  press: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddAllBasketOrderView(
                              orderAddressType: "Home",
                              lat: "${lat}",
                              long: "${long}",
                              address: "${address}",
                              number: 5,
                            );
                          },
                        ),
                      );
                    }
                  },
                  btnColor: ColorManager.mainColor,
                  paddingVertical: 8.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
