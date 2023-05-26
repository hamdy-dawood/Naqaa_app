import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/snack_and_navigate.dart';
import 'package:naqaa/pages/basket/components/basket_item.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';

import 'cubit.dart';
import 'states.dart';

class BasketView extends StatelessWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = BasketCubit.get(context);
      cubit.getBaskets();

      return RefreshIndicator(
        backgroundColor: ColorManager.mainColor,
        color: Colors.white,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          cubit.getBaskets();
        },
        child: Scaffold(
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
          body: BlocBuilder<BasketCubit, BasketStates>(
            builder: (context, state) {
              if (state is BasketLoadingState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  customWillPopScope(context);
                });
                return const SizedBox();
              } else if (state is BasketFailureState) {
                Navigator.pop(context);
                return Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Text(state.msg),
                );
              } else if (state is NetworkErrorState) {
                return ErrorNetwork(
                  press: () {
                    cubit.getBaskets();
                  },
                );
              }
              Navigator.pop(context);
              return SizedBox(
                width: 1.sw,
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.53.sh,
                      child: ListView.builder(
                          itemCount: cubit.baskets.length,
                          itemBuilder: (context, index) {
                            final baskets = cubit.baskets[index];
                            return BasketItem(
                              title: "${baskets.productName}",
                              subTitle: "${baskets.productDescription}",
                              price: "${baskets.productPrice}",
                              image:
                                  "${UrlsStrings.baseImageUrl}${baskets.productImage}",
                              quantity: "${baskets.basketQuantity}",
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
                                  text: "QR ",
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
                                  text: "QR ",
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
                                  text: "QR ",
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
                                    press: () {
                                      navigateTo(
                                          page: const NavBarView(),
                                          withHistory: false);
                                    },
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
                                    press: () {
                                      context
                                          .read<NavBarCubit>()
                                          .navigateToIndex(4);
                                    },
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
              );
            },
          ),
        ),
      );
    });
  }
}
