import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/pages/home/components/product_item.dart';

import 'cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllProductsCubit(),
      child: Builder(builder: (context) {
        final cubit = AllProductsCubit.get(context);
        // cubit.getAllProducts();

        return RefreshIndicator(
          backgroundColor: ColorManager.mainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            cubit.getAllProducts();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {},
                icon: SvgIcon(
                  height: 22.h,
                  icon: "assets/icons/location.svg",
                  color: ColorManager.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgIcon(
                    height: 22.h,
                    icon: "assets/icons/notification.svg",
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
            body: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15.h),
                  child: CustomText(
                    text: "اختر منتج",
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                BlocBuilder<AllProductsCubit, AllProductsStates>(
                  builder: (context, state) {
                    if (state is AllProductsLoadingState) {
                      return customWillPopScope(context);
                    } else if (state is AllProductsFailedState) {
                      return Text(state.msg);
                    } else if (state is NetworkErrorState) {
                      return ErrorNetwork(press: () {
                        cubit.getAllProducts();
                      });
                    }
                    return SizedBox(
                      height: 0.72.sh,
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const ProductItem(
                              title: "حجم 1.5 لتر *6 عبوة (شدة)",
                              subTitle: "إنتاج مياة الدوحة خصيصا لنقاء",
                              price: "QR 5.00",
                              image: "",
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
