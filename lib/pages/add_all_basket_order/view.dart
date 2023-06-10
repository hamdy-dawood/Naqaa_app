import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';

import 'cubit.dart';
import 'states.dart';

class AddAllBasketOrderView extends StatelessWidget {
  const AddAllBasketOrderView(
      {Key? key,
      required this.orderAddressType,
      required this.address,
      required this.lat,
      required this.long})
      : super(key: key);

  final String orderAddressType, address, lat, long;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAllBasketOrderCubit(),
      child: Builder(
        builder: (context) {
          final cubit = AddAllBasketOrderCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.mainColor,
              elevation: 0.0,
              centerTitle: true,
              title: CustomText(
                text: "complete_order".tr,
                color: ColorManager.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 22.sp,
                  color: ColorManager.white,
                ),
              ),
            ),
            body: SizedBox(
              width: 1.sw,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    CustomText(
                      text: "$orderAddressType",
                      color: ColorManager.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      text: "$address",
                      color: ColorManager.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      text: "Lat: $lat",
                      color: ColorManager.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      text: "Long: $long",
                      color: ColorManager.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                    BlocConsumer<AddAllBasketOrderCubit,
                        AddAllBasketOrderStates>(
                      listener: (context, state) {
                        if (state is AddAllBasketOrderFailureState) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: state.msg);
                        } else if (state is AddAllBasketOrderSuccessState) {
                          for (var i = 0; i < 4; i++) {
                            Navigator.pop(context);
                          }
                          NavBarCubit.get(context).navigateToNavBarView(2);
                          Fluttertoast.showToast(msg: "order_added".tr);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddAllBasketOrderLoadingState) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            customWillPopScope(context);
                          });
                          return const SizedBox();
                        }
                        return Padding(
                          padding: EdgeInsets.all(20.h),
                          child: CustomElevated(
                            text: "complete_order".tr,
                            press: () {
                              cubit.addAllBasketOrder(
                                orderAddressType: orderAddressType,
                                lat: lat,
                                long: long,
                                address: address,
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
            ),
          );
        },
      ),
    );
  }
}
