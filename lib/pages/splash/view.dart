import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';
import 'package:naqaa/pages/login/view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // bool isFirstTime = CacheHelper.getIfFirstTime();
  String token = CacheHelper.getToken();

  @override
  void initState() {
    super.initState();
    _goNext();
  }

  _goNext() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return token.isEmpty ? const LoginView() : const NavBarView();
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
