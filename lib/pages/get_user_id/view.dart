import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/core/navigate.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';

import 'cubit.dart';
import 'states.dart';

class GetUserIDView extends StatelessWidget {
  const GetUserIDView({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final cubit = GetUserIDCubit.get(context);
        return Scaffold(
          body: ListView(
            children: [
              SizedBox(
                height: 200,
              ),
              CustomText(
                text: phone,
                color: ColorManager.mainColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              BlocConsumer<GetUserIDCubit, GetUserIDStates>(
                listener: (context, state) {
                  if (state is GetUserIDFailureState) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: state.msg);
                  } else if (state is NetworkErrorState) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "check_online".tr);
                  } else if (state is GetUserIDLoadingState) {
                    customWillPopScope(context);
                  } else if (state is GetUserIDSuccessState) {
                    navigateTo(page: NavBarView(), withHistory: false);
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.17.sw),
                    child: CustomElevated(
                      text: "دخول",
                      press: () {
                        cubit.getUserID(phone: phone);
                      },
                      btnColor: ColorManager.mainColor,
                      fontSize: 18.sp,
                      borderRadius: 8.r,
                      paddingVertical: 5.w,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
