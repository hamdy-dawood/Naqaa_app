import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/delete_dialog.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/core/snack_and_navigate.dart';
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
    String token = CacheHelper.getUserID();
    return Builder(
      builder: (context) {
        final cubit = BasketCubit.get(context);
        final removeCubit = RemoveProductBasketCubit.get(context);
        final removeAllCubit = RemoveAllBasketCubit.get(context);

        cubit.getBaskets();

        return token.isNotEmpty
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
                        onTap: () {
                          deleteDialog(
                            context: context,
                            title: "هل أنت متأكد من إزالة ما في السلة؟",
                            yesPress: () {
                              removeAllCubit.removeAllBasket();
                              Navigator.pop(context);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
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
                        return ErrorNetwork(
                          press: () {
                            cubit.getBaskets();
                          },
                        );
                      } else if (state is BasketSuccessWithNoDataState) {
                        Navigator.pop(context);
                        return Center(
                          child: CustomText(
                            text: "سلتك فارغة!",
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
                            SizedBox(
                              height: 0.53.sh,
                              child: ListView.builder(
                                  itemCount: cubit.baskets.length,
                                  itemBuilder: (context, index) {
                                    final baskets = cubit.baskets[index];
                                    return BasketItem(
                                        itemPress: () {
                                          navigateTo(
                                            page: ChooseAddressType(
                                              productID: "${baskets.productId}",
                                              quantity:
                                                  "${baskets.basketQuantity}",
                                              basketID: "${baskets.basketId}",
                                            ),
                                          );
                                        },
                                        title: "${baskets.productName}",
                                        subTitle:
                                            "${baskets.productDescription}",
                                        price: "${baskets.productPrice}",
                                        image:
                                            "${UrlsStrings.baseImageUrl}${baskets.productImage}",
                                        quantity: "${baskets.basketQuantity}",
                                        yesPress: () {
                                          removeCubit.removeProduct(
                                              basketID: "${baskets.basketId}");
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                              context
                                                  .read<NavBarCubit>()
                                                  .navigateToIndex(0);
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
                                              // navigateTo(
                                              //     page:
                                              //         const ChooseAddressType());
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
              )
            : Scaffold(
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
                body: Center(
                  child: CustomText(
                    text: "سلتك فارغة!",
                    color: ColorManager.mainColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              );
      },
    );
  }
}
