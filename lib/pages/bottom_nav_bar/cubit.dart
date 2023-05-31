import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';
import 'package:naqaa/pages/login/view.dart';

import 'controller.dart';
import 'states.dart';

class NavBarCubit extends Cubit<NavBarStates> {
  NavBarCubit() : super(NavBarInitialState());

  static NavBarCubit get(context) => BlocProvider.of(context);

  final controller = NavBarController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  selectItem(index) {
    String userID = CacheHelper.getUserID();
    if (index == 2 && userID.isEmpty) {
      Navigator.of(scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } else if (index == 4 && userID.isEmpty) {
      Navigator.of(scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    } else {
      if (userID.isEmpty) {
        controller.selectedItem = 0;
        print('1. Selected Item: ${controller.selectedItem}');
      } else {
        controller.selectedItem = index;
        print('2. Selected Item: ${controller.selectedItem}');
      }
    }
    emit(SelectItemState());
  }

  void navigateToNavBarView(int index) {
    selectItem(index);
    if (index != controller.selectedItem) {
      scaffoldKey.currentState?.showBottomSheet(
        (context) => const NavBarView(),
      );
    }
  }
}
