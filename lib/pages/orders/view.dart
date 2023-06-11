import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';

import 'components/orders_item.dart';
import 'cubit.dart';
import 'states.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(),
      child: Builder(
        builder: (context) {
          final cubit = OrdersCubit.get(context);
          cubit.getOrders(status: 1);
          return RefreshIndicator(
            backgroundColor: ColorManager.mainColor,
            color: Colors.white,
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 500));
              cubit.getOrders(status: 1);
            },
            child: BlocBuilder<OrdersCubit, OrdersStates>(
              builder: (context, state) {
                if (state is OrdersLoadingState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    customWillPopScope(context);
                  });
                  return const SizedBox();
                } else if (state is OrdersFailureState) {
                  Navigator.pop(context);
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.h),
                      child: Text(state.msg),
                    ),
                  );
                } else if (state is OrdersSuccessWithNoDataState) {
                  Navigator.pop(context);
                  return Form(
                    key: cubit.emptyFormKey,
                    child: Scaffold(
                      backgroundColor: ColorManager.white,
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: ColorManager.white,
                        elevation: 0.0,
                        centerTitle: false,
                        title: CustomText(
                          text: "order_history".tr,
                          color: ColorManager.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        actions: [
                          BlocBuilder<OrdersCubit, OrdersStates>(
                            builder: (context, state) {
                              return DropdownButton<String>(
                                key: cubit.dropDownKey,
                                icon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: SvgIcon(
                                    height: 18.h,
                                    icon: AssetsStrings.filterIcon,
                                    color: ColorManager.black,
                                  ),
                                ),
                                alignment: Alignment.center,
                                dropdownColor: ColorManager.white,
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10),
                                underline: const SizedBox.shrink(),
                                onChanged: (value) {
                                  cubit.setSelectedItem(value);
                                  if (value == cubit.filterItems[0].tr) {
                                    cubit.getOrders(status: 1);
                                  } else if (value == cubit.filterItems[1].tr) {
                                    cubit.getOrders(status: 2);
                                  } else if (value == cubit.filterItems[2].tr) {
                                    cubit.getOrders(status: 3);
                                  }
                                },
                                value: cubit.selectedItem,
                                items: List.generate(
                                  cubit.filterItems.length,
                                  (index) => DropdownMenuItem(
                                    value: cubit.filterItems[index].tr,
                                    child: CustomText(
                                      text: cubit.filterItems[index].tr,
                                      color: ColorManager.mainColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      body: Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Center(
                          child: CustomText(
                            text: "no_orders".tr,
                            color: ColorManager.mainColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is OrdersNetworkErrorState) {
                  Navigator.pop(context);
                  return ErrorNetwork(
                    press: () {
                      cubit.getOrders(status: 1);
                    },
                  );
                }
                Navigator.pop(context);
                return Form(
                  key: cubit.formKey,
                  child: Scaffold(
                    backgroundColor: ColorManager.white,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: ColorManager.white,
                      elevation: 0.0,
                      centerTitle: false,
                      title: CustomText(
                        text: "order_history".tr,
                        color: ColorManager.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      actions: [
                        BlocBuilder<OrdersCubit, OrdersStates>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              key: cubit.formKey,
                              icon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: SvgIcon(
                                  height: 18.h,
                                  icon: AssetsStrings.filterIcon,
                                  color: ColorManager.black,
                                ),
                              ),
                              alignment: Alignment.center,
                              dropdownColor: ColorManager.white,
                              elevation: 1,
                              borderRadius: BorderRadius.circular(10),
                              underline: const SizedBox.shrink(),
                              onChanged: (value) {
                                cubit.setSelectedItem(value);
                                if (value == cubit.filterItems[0].tr) {
                                  cubit.getOrders(status: 1);
                                } else if (value == cubit.filterItems[1].tr) {
                                  cubit.getOrders(status: 2);
                                } else if (value == cubit.filterItems[2].tr) {
                                  cubit.getOrders(status: 3);
                                }
                              },
                              value: cubit.selectedItem,
                              items: List.generate(
                                cubit.filterItems.length,
                                (index) => DropdownMenuItem(
                                  value: cubit.filterItems[index].tr,
                                  child: CustomText(
                                    text: cubit.filterItems[index].tr,
                                    color: ColorManager.mainColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    body: SizedBox(
                      width: 1.sw,
                      child: ListView.builder(
                        itemCount: cubit.orders.length,
                        itemBuilder: (context, index) {
                          final order = cubit.orders[index];
                          return OrdersItem(
                            id: "${order.basketTicketID}",
                            count: "${order.count}",
                            status: "${order.basketOrderStatus}",
                            price: "${order.basketPrice}",
                            addressType: "${order.basketTypeAddress}",
                            time: "${order.basketTime}",
                          );
                        },
                      ),
                    ),
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
