import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/basket/components/order_item.dart';

class BasketView extends StatelessWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.mainColor,
        elevation: 0.0,
        centerTitle: false,
        title: CustomText(
          text: "إتمام الطلب",
          color: ColorManager.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SvgIcon(
                height: 20.h,
                icon: AssetsStrings.deleteIcon,
                color: ColorManager.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: 1.sw,
        child: Column(
          children: [
            SizedBox(
              height: 0.53.sh,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return const OrderItem(
                      title: "حجم 1.5 لتر *6 عبوة (شدة)",
                      subTitle: "إنتاج مياة الدوحة خصيصا لنقاء",
                      price: "QR 5.00",
                      image: "",
                    );
                  }),
            ),
            const Spacer(),
            Divider(
              color: ColorManager.mainColor,
              thickness: 0.5,
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "قيمة الطلب",
                          color: ColorManager.borderColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.normal,
                        ),
                        CustomText(
                          text: "QR 5",
                          color: ColorManager.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "رسوم التوصيل",
                          color: ColorManager.borderColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "QR 10",
                          color: ColorManager.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "الإجمالي",
                          color: ColorManager.mainColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          text: "QR 15",
                          color: ColorManager.mainColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevated(
                            text: "إضافة المزيد",
                            press: () {},
                            btnColor: ColorManager.white,
                            textColor: ColorManager.mainColor,
                            fontSize: 16.sp,
                            borderRadius: 8.r,
                            paddingVertical: 5.w,
                          ),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
                        Expanded(
                          child: CustomElevated(
                            text: "إتمام الطلب",
                            press: () {},
                            btnColor: ColorManager.mainColor,
                            fontSize: 16.sp,
                            borderRadius: 8.r,
                            paddingVertical: 5.w,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
