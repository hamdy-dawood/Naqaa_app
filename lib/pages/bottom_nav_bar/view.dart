import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/basket/view.dart';
import 'package:naqaa/pages/home/view.dart';
import 'package:naqaa/pages/login/view.dart';
import 'package:naqaa/pages/orders/view.dart';
import 'package:naqaa/pages/profile/view.dart';
import 'package:naqaa/pages/search/view.dart';

import 'bottom_bar_item.dart';
import 'cubit.dart';
import 'states.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String token = CacheHelper.getUserID();
    List screens = [
      const HomeView(),
      const SearchView(),
      token.isEmpty ? const LoginView() : const OrdersView(),
      const BasketView(),
      token.isEmpty ? const LoginView() : const ProfileView(),
    ];

    return Builder(builder: (context) {
      final cubit = NavBarCubit.get(context);
      return BlocBuilder<NavBarCubit, NavBarStates>(
        builder: (context, state) {
          return Scaffold(
            key: cubit.scaffoldKey,
            body: screens[cubit.controller.selectedItem],
            bottomNavigationBar: Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: ColorManager.mainColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  topLeft: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  cubit.controller.icons.length,
                  (index) => BottomBarItem(
                    onPress: () {
                      cubit.selectItem(index);
                    },
                    icon: cubit.controller.icons[index],
                    selectedIcon: cubit.controller.selectedIcons[index],
                    label: cubit.controller.labels[index],
                    isSelected: index == cubit.controller.selectedItem,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
