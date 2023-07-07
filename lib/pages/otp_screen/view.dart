import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';
import 'package:naqaa/pages/get_user_id/cubit.dart';
import 'package:naqaa/pages/get_user_id/states.dart';
import 'package:pinput/pinput.dart';

import 'cubit.dart';

class OtpView extends StatelessWidget {
  const OtpView({Key? key, required this.phone}) : super(key: key);
  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(),
      child: Builder(builder: (context) {
        final cubit = OtpCubit.get(context);
        final getUserCubit = GetUserIDCubit.get(context);
        cubit.generateNumber();
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: ColorManager.black,
                size: 30.sp,
              ),
            ),
            title: CustomText(
              text: "otp_verify".tr,
              color: ColorManager.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: false,
          ),
          body: SizedBox(
            width: 1.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: SvgPicture.asset(
                      AssetsStrings.logoIcon,
                      height: 120.h,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomText(
                    text: "sending_code".tr,
                    color: ColorManager.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    maxLines: 10,
                    textAlign: TextAlign.center,
                  ),
                  Localizations.override(
                    context: context,
                    locale: Locale('en'),
                    child: CustomText(
                      text: phone,
                      color: ColorManager.mainColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 0.05.sh,
                    ),
                    child: Localizations.override(
                      context: context,
                      locale: Locale('en'),
                      child: Pinput(
                        length: 4,
                        controller: cubit.otpController,
                        defaultPinTheme: PinTheme(
                          height: 60.h,
                          width: 55.h,
                          textStyle: GoogleFonts.almarai(
                            textStyle: TextStyle(
                              color: ColorManager.mainColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: ColorManager.mainColor),
                          ),
                        ),
                        validator: (otp) {
                          if ((otp!.length != 4)) {
                            return "otp_validator".tr;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NavBarView();
                            },
                          ),
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.17.sw),
                        child: CustomElevated(
                          text: "verify".tr,
                          press: () {
                            if (cubit.otpController.text !=
                                cubit.randomNumber) {
                              Fluttertoast.showToast(msg: "wrong otp");
                            } else {
                              getUserCubit.getUserID(phone: phone);
                            }
                          },
                          btnColor: ColorManager.mainColor,
                          fontSize: 18.sp,
                          borderRadius: 8.r,
                          paddingVertical: 5.w,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  FittedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "don't_receive".tr,
                            color: ColorManager.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          TextButton(
                            onPressed: () {
                              cubit.generateNumber();
                            },
                            child: CustomText(
                              text: "send_again".tr,
                              color: ColorManager.mainColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
