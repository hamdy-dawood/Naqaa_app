import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/decor_container.dart';
import 'package:naqaa/constants/strings.dart';

import 'components/order_details_item.dart';
import 'cubit.dart';
import 'states.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({Key? key, required this.orderID}) : super(key: key);
  final String orderID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = OrderDetailsCubit.get(context);
          cubit.getOrderDetails(ID: orderID);

          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
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
                text: "order_detail".tr,
                color: ColorManager.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            body: BlocBuilder<OrderDetailsCubit, OrderDetailsStates>(
              builder: (context, state) {
                if (state is OrderDetailsLoadingState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    customWillPopScope(context);
                  });
                  return const SizedBox();
                } else if (state is OrderDetailsFailureState) {
                  Navigator.pop(context);
                  return Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(state.msg),
                  );
                } else if (state is NetworkErrorState) {
                  Navigator.pop(context);
                  return ErrorNetwork(
                    press: () {
                      cubit.getOrderDetails(ID: orderID);
                    },
                  );
                }
                Navigator.pop(context);
                return SizedBox(
                  width: 1.sw,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: "order_id".tr,
                              color: ColorManager.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              text: orderID,
                              color: ColorManager.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.h, vertical: 8.h),
                        padding: EdgeInsets.all(8.h),
                        decoration: containerDecoration(
                          borderColor: ColorManager.borderColor,
                        ),
                        child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cubit.orderDetails.length,
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
                              final baskets = cubit.orderDetails[index];
                              return OrderItem(
                                title: "${baskets.productName}",
                                enTitle: "${baskets.productNameEN}",
                                subTitle: "${baskets.productDescription}",
                                enSubTitle: "${baskets.productDescriptionEN}",
                                price: "${baskets.productPrice}",
                                image:
                                    "${UrlsStrings.baseImageUrl}${baskets.productImage}",
                                quantity: "${baskets.basketQuantity}",
                                addressType: "${baskets.basketTypeAddress}",
                              );
                            }),
                      ),
                      SizedBox(height: 10.w),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.h),
                        child: CustomText(
                          text: "receiver_details".tr,
                          color: ColorManager.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.h, vertical: 8.h),
                        padding: EdgeInsets.all(8.h),
                        decoration: containerDecoration(
                          borderColor: ColorManager.borderColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgIcon(
                                  height: 22.h,
                                  icon: AssetsStrings.locationIcon,
                                  color: ColorManager.black,
                                ),
                                SizedBox(width: 20.w),
                                CustomText(
                                  text: "home",
                                  color: ColorManager.black,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            CustomText(
                              text:
                                  "${cubit.orderDetails[0].basketTypeAddress}",
                              color: ColorManager.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              maxLines: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
