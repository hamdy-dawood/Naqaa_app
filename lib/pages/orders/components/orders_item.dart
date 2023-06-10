import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/decor_container.dart';
import 'package:naqaa/pages/order_details/view.dart';

class OrdersItem extends StatelessWidget {
  const OrdersItem({
    Key? key,
    required this.id,
    required this.count,
    required this.status,
    required this.price,
    required this.addressType,
    required this.time,
  }) : super(key: key);

  final String id, count, status, price, addressType, time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OrderDetailsView(
                orderID: id,
                price: price,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.h),
        padding: EdgeInsets.all(8.h),
        decoration: containerDecoration(
          borderColor: ColorManager.borderColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      CustomText(
                        text: "order_id".tr,
                        color: ColorManager.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomText(
                        text: "${id}",
                        color: ColorManager.mainColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: status == "1"
                        ? Colors.yellow[50]
                        : status == "2"
                            ? Colors.green[100]
                            : Colors.red[100],
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cancel,
                        color: status == "1"
                            ? Colors.yellow
                            : status == "2"
                                ? Colors.green
                                : Colors.red,
                        size: 22.sp,
                      ),
                      SizedBox(width: 3.w),
                      CustomText(
                        text: status == "1"
                            ? "pending".tr.toUpperCase()
                            : status == "2"
                                ? "done".tr.toUpperCase()
                                : "canceled".tr.toUpperCase(),
                        color: ColorManager.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "order_items".tr,
                  color: ColorManager.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
                CustomText(
                  text: "${count}",
                  color: ColorManager.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Row(
                      children: [
                        CustomText(
                          text: "date_time".tr,
                          color: ColorManager.borderColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: "${time}",
                          color: ColorManager.borderColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                CustomText(
                  text: "${price} QR",
                  color: ColorManager.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
