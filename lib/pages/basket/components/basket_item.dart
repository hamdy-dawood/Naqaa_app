import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/delete_dialog.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.image,
    required this.quantity,
    required this.yesPressDelete,
    required this.itemPress,
  }) : super(key: key);

  final String title, subTitle, price, image, quantity;
  final VoidCallback itemPress, yesPressDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.h),
        padding: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: ColorManager.mainColor,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.darkGrey,
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
                  text: "delivery_address".tr,
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
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Image.network(image),
                  ),
                ),
                SizedBox(width: 10.h),
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
                            onPressed: () {
                              deleteDialog(
                                context: context,
                                title: "delete".tr,
                                subTitle: "delete_item_sub".tr,
                                yesPress: yesPressDelete,
                              );
                            },
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
                        color: ColorManager.darkGrey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: "${price} QR",
                              color: ColorManager.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CustomElevated(
                              text: "Qty $quantity",
                              press: () {},
                              btnColor: ColorManager.white,
                              textColor: ColorManager.mainColor,
                              fontSize: 15.sp,
                              paddingHorizontal: 10.w,
                            ),
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
      ),
    );
  }
}
