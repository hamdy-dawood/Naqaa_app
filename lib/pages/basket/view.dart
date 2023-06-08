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
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/address_type/view2.dart';
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
                  child: Scaffold(
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
                          Navigator.pop(context);
                          return ErrorNetwork(
                            press: () {
                              cubit.getBaskets();
                            },
                          );
                        } else if (state is BasketSuccessWithNoDataState) {
                          Navigator.pop(context);
                          return Center(
                            child: CustomText(
                              text: "empty_cart".tr,
                              color: ColorManager.mainColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          );
                        }
                        Navigator.pop(context);
                        return SizedBox(
                          width: 1.sw,
                          child: Column(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 0.53.sh,
                                  child: ListView.builder(
                                    itemCount: cubit.baskets.length,
                                    itemBuilder: (context, index) {
                                      final baskets = cubit.baskets[index];
                                      return BasketItem(
                                          itemPress: () {
                                            // if (int.parse(cubit.total) < 129) {
                                            //   Fluttertoast.showToast(
                                            //       msg:
                                            //           "Minimum Order Value is QR 129 and if Products is Out of Stock"
                                            //           "then New Stock will be available Soon!! Try Again Later");
                                            // } else {
                                            //   Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           ChooseAddressType(
                                            //         productID:
                                            //             "${baskets.productId}",
                                            //         quantity:
                                            //             "${baskets.basketQuantity}",
                                            //         basketID:
                                            //             "${baskets.basketId}",
                                            //       ),
                                            //     ),
                                            //   );
                                            // }
                                          },
                                          title: "${baskets.productName}",
                                          subTitle:
                                              "${baskets.productDescription}",
                                          price: "${baskets.productPrice}",
                                          image:
                                              "${UrlsStrings.baseImageUrl}${baskets.productImage}",
                                          quantity: "${baskets.basketQuantity}",
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
                                ),
                              ),
                              SizedBox(
                                height: 0.25.sh,
                                width: 1.sw,
                                child: ListView(
                                  children: [
                                    Divider(
                                      color: ColorManager.mainColor,
                                      thickness: 0.5,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: SizedBox(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: "order_val".tr,
                                                  color:
                                                      ColorManager.borderColor,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: "delivery_char".tr,
                                                  color:
                                                      ColorManager.borderColor,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: "total".tr,
                                                  color: ColorManager.mainColor,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                CustomText(
                                                  text:
                                                      "QR ${int.parse(cubit.total) + 10}",
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
                                                          NavBarCubit.get(
                                                              context);
                                                      navBarCubit
                                                          .navigateToNavBarView(
                                                              0);
                                                    },
                                                    btnColor:
                                                        ColorManager.white,
                                                    textColor:
                                                        ColorManager.mainColor,
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
                                                      if (int.parse(
                                                              cubit.total) <
                                                          129) {
                                                        Fluttertoast.showToast(
                                                            msg: "cart_minimum"
                                                                .tr);
                                                      } else {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ChooseAddressType2(),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    btnColor:
                                                        ColorManager.mainColor,
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
                            ],
                          ),
                        );
                      },
                    ),
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
