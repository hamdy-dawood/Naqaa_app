import 'package:flutter/material.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void navigateTo(
    {required Widget page, bool withHistory = true, int index = 0}) {
  final context = navigatorKey.currentContext!;
  if (withHistory) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
  NavBarCubit.get(context).navigateToNavBarView(index);
}

// navigateTo(context, screen) =>
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
//
// void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
//     context, MaterialPageRoute(builder: (context) => widget), (route) => false);
//
// navigateAndReplace(context, screen) => Navigator.of(context)
//     .pushReplacement(MaterialPageRoute(builder: (_) => screen));
