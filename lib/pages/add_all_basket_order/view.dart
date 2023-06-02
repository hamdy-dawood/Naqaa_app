import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      required this.lat,
      required this.long})
      : super(key: key);

  final String orderAddressType, lat, long;

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
                text: "إتمام الطلب",
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: "orderAddressType : $orderAddressType",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: "Lat: $lat",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: "Long: $long",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  BlocConsumer<AddAllBasketOrderCubit, AddAllBasketOrderStates>(
                    listener: (context, state) {
                      if (state is AddAllBasketOrderFailureState) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: state.msg);
                      } else if (state is AddAllBasketOrderSuccessState) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        NavBarCubit.get(context).navigateToNavBarView(2);
                        Fluttertoast.showToast(msg: "success");
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
                          text: "اتمام الطلب",
                          press: () {
                            cubit.addAllBasketOrder(
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
      ),
    );
  }
}
