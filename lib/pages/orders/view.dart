import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/orders/states.dart';

import 'components/order_item.dart';
import 'cubit.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = OrdersCubit.get(context);
        cubit.getOrders();

        return RefreshIndicator(
          backgroundColor: ColorManager.mainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            cubit.getOrders();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              centerTitle: false,
              title: CustomText(
                text: "أحداث الطلبات",
                color: ColorManager.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SvgIcon(
                      height: 20.h,
                      icon: AssetsStrings.filterIcon,
                      color: ColorManager.black,
                    ),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<OrdersCubit, OrdersStates>(
              builder: (context, state) {
                if (state is OrdersLoadingState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    customWillPopScope(context);
                  });
                  return const SizedBox();
                } else if (state is OrdersFailureState) {
                  Navigator.pop(context);
                  return Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(state.msg),
                  );
                } else if (state is OrdersSuccessWithNoDataState) {
                  Navigator.pop(context);
                  return Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Center(
                        child: CustomText(
                      text: "لا توجد طلبات بعد",
                      color: ColorManager.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    )),
                  );
                } else if (state is NetworkErrorState) {
                  return ErrorNetwork(
                    press: () {
                      cubit.getOrders();
                    },
                  );
                }
                Navigator.pop(context);
                return SizedBox(
                  width: 1.sw,
                  child: ListView.builder(
                      itemCount: cubit.orders.length,
                      itemBuilder: (context, index) {
                        final baskets = cubit.orders[index];
                        return OrderItem(
                          title: "${baskets.productName}",
                          subTitle: "${baskets.productDescription}",
                          price: "${baskets.productPrice}",
                          image:
                              "${UrlsStrings.baseImageUrl}${baskets.productImage}",
                          quantity: "${baskets.orderQuantity}",
                          addressType: "${baskets.orderTypeAddress}",
                        );
                      }),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
