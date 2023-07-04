import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/delete_dialog.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/decor_container.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/address_type/view.dart';
import 'package:naqaa/pages/basket/components/basket_item.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';
import 'package:naqaa/pages/remove_all_basket/cubit.dart';
import 'package:naqaa/pages/remove_product_from_basket/cubit.dart';

import 'cubit.dart';
import 'states.dart';

class BasketView extends StatelessWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userID = CacheHelper.getUserID();

    return BlocProvider(
      create: (context) => BasketCubit(),
      child: Builder(
        builder: (context) {
          final cubit = BasketCubit.get(context);
          final removeCubit = RemoveProductBasketCubit.get(context);
          final removeAllCubit = RemoveAllBasketCubit.get(context);

          cubit.getBaskets();
          return userID.isNotEmpty
              ? RefreshIndicator(
                  backgroundColor: ColorManager.mainColor,
                  color: Colors.white,
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    cubit.getBaskets();
                  },
                  child: BlocBuilder<BasketCubit, BasketStates>(
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
                        Navigator.pop(context);
                        return ErrorNetwork();
                      } else if (state is BasketSuccessWithNoDataState) {
                        Navigator.pop(context);
                        return Scaffold(
                          backgroundColor: ColorManager.white,
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: ColorManager.mainColor,
                            elevation: 0.0,
                            centerTitle: false,
                            title: CustomText(
                              text: "complete_order".tr,
                              color: ColorManager.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            actions: [
                              InkWell(
                                onTap: () {
                                  deleteDialog(
                                    context: context,
                                    title: "delete".tr,
                                    subTitle: "delete_all_sub".tr,
                                    yesPress: () {
                                      removeAllCubit.removeAllBasket();
                                      Navigator.pop(context);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        customWillPopScope(context);
                                      });
                                      Future.delayed(
                                        const Duration(seconds: 1),
                                        () {
                                          Navigator.pop(context);
                                          cubit.getBaskets();
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: SvgIcon(
                                    height: 20.h,
                                    icon: AssetsStrings.deleteIcon,
                                    color: ColorManager.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          body: Center(
                            child: CustomText(
                              text: "empty_cart".tr,
                              color: ColorManager.mainColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        );
                      }
                      Navigator.pop(context);
                      return Scaffold(
                        backgroundColor: ColorManager.white,
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: ColorManager.mainColor,
                          elevation: 0.0,
                          centerTitle: false,
                          title: CustomText(
                            text: "complete_order".tr,
                            color: ColorManager.white,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                deleteDialog(
                                  context: context,
                                  title: "delete".tr,
                                  subTitle: "delete_all_sub".tr,
                                  yesPress: () {
                                    removeAllCubit.removeAllBasket();
                                    Navigator.pop(context);
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      customWillPopScope(context);
                                    });
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                      () {
                                        Navigator.pop(context);
                                        cubit.getBaskets();
                                      },
                                    );
                                  },
                                );
                              },
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
                        bottomSheet: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "order_val".tr,
                                          color: ColorManager.borderColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CustomText(
                                          text: "QR ${cubit.total}",
                                          color: ColorManager.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "delivery_char".tr,
                                          color: ColorManager.borderColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CustomText(
                                          text: "QR 10",
                                          color: ColorManager.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: "total".tr,
                                          color: ColorManager.mainColor,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        CustomText(
                                          text: "QR ${cubit.total + 10}",
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
                                            text: "add_more".tr,
                                            press: () {
                                              final navBarCubit =
                                                  NavBarCubit.get(context);
                                              navBarCubit
                                                  .navigateToNavBarView(0);
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
                                            text: "complete_order".tr,
                                            press: () {
                                              if (cubit.total < 129) {
                                                Fluttertoast.showToast(
                                                    msg: "cart_minimum".tr);
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChooseAddressType(),
                                                  ),
                                                );
                                              }
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
                        body: SizedBox(
                          width: 1.sw,
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.h, vertical: 8.h),
                                padding: EdgeInsets.all(8.h),
                                decoration: containerDecoration(
                                  borderColor: ColorManager.mainColor,
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
                                      height: 10.h,
                                    ),
                                    ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: cubit.baskets.length,
                                      separatorBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            right: 5.w,
                                            left: 5.w,
                                            bottom: 8.h,
                                            top: 3.h,
                                          ),
                                          child: Divider(
                                            color: ColorManager.mainColor,
                                            thickness: 0.5,
                                          ),
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        final baskets = cubit.baskets[index];
                                        return BasketItem(
                                            basketID: "${baskets.basketId}",
                                            title: "${baskets.productName}",
                                            subTitle:
                                                "${baskets.productDescription}",
                                            enTitle: "${baskets.productNameEN}",
                                            enSubTitle:
                                                "${baskets.productDescriptionEN}",
                                            price: "${baskets.productPrice}",
                                            image:
                                                "${UrlsStrings.baseImageUrl}${baskets.productImage}",
                                            quantity:
                                                "${baskets.basketQuantity}",
                                            yesPressDelete: () {
                                              removeCubit.removeProduct(
                                                  basketID:
                                                      "${baskets.basketId}");
                                              Navigator.pop(context);
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                customWillPopScope(context);
                                              });
                                              Future.delayed(
                                                const Duration(seconds: 1),
                                                () {
                                                  Navigator.pop(context);
                                                  cubit.getBaskets();
                                                },
                                              );
                                            });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 200.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: ColorManager.mainColor,
                    elevation: 0.0,
                    centerTitle: false,
                    title: CustomText(
                      text: "complete_order".tr,
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
                  body: Center(
                    child: CustomText(
                      text: "empty_cart".tr,
                      color: ColorManager.mainColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
