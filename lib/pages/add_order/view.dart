import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';

import 'cubit.dart';
import 'states.dart';

class AddOrderView extends StatelessWidget {
  const AddOrderView({
    Key? key,
    required this.productID,
    required this.quantity,
    required this.basketId,
    required this.orderAddressType,
    required this.lat,
    required this.long,
  }) : super(key: key);

  final String productID, quantity, basketId, orderAddressType, lat, long;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = AddOrderCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.mainColor,
            elevation: 0.0,
            centerTitle: true,
            title: CustomText(
              text: "إتمام الطلب",
              color: ColorManager.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SizedBox(
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  text: "product id : $productID",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: "quantity : $quantity",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: "basket Id : $basketId",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: "orderAddressType : $orderAddressType",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: "lat: $lat",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                CustomText(
                  text: "long : $long",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
                BlocConsumer<AddOrderCubit, AddOrderStates>(
                  listener: (context, state) {
                    if (state is AddOrderFailureState) {
                      Navigator.pop(context);
                      print(state.msg);
                    } else if (state is AddOrderSuccessState) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      context.read<NavBarCubit>().navigateToIndex(2);
                      // print("success");
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return const NavBarView();
                      // }));
                    }
                  },
                  builder: (context, state) {
                    if (state is AddOrderLoadingState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        customWillPopScope(context);
                      });
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.all(20.h),
                      child: CustomElevated(
                        text: "اتمام الطلب",
                        press: () {
                          cubit.addOrder(
                            productID: productID,
                            quantity: quantity,
                            basketId: basketId,
                            orderAddressType: orderAddressType,
                            lat: lat,
                            long: long,
                          );
                        },
                        btnColor: ColorManager.mainColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}