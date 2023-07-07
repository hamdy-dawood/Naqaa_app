import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/navigate.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';
import 'package:naqaa/pages/login/states.dart';
import 'package:naqaa/pages/otp_screen/view.dart';

import 'cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(builder: (context) {
        final cubit = LoginCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            actions: [
              TextButton(
                onPressed: () {
                  navigateTo(page: NavBarView());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomText(
                    text: "skip".tr,
                    color: ColorManager.mainColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
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
                  CustomText(
                    text: "login".tr,
                    color: ColorManager.mainColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomText(
                    text: "proceed_number".tr,
                    color: ColorManager.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Form(
                    key: cubit.formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: ColorManager.borderColor,
                        ),
                      ),
                      child: Localizations.override(
                        context: context,
                        locale: Locale("en"),
                        child: InternationalPhoneNumberInput(
                          maxLength: 8,
                          initialValue: PhoneNumber(isoCode: "QA"),
                          onInputChanged: (PhoneNumber number) {
                            cubit.onInputChanged(number);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "phone_validator".tr;
                            } else if (value.length > 8) {
                              return "text_valid".tr;
                            }
                            return null;
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorTextStyle:
                              TextStyle(color: ColorManager.black),
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                          inputDecoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(right: 10.w, bottom: 8.w),
                            border: InputBorder.none,
                            hintText: "mobile_number".tr,
                            hintStyle: GoogleFonts.redHatDisplay(
                              color: ColorManager.borderColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<LoginCubit, LoginStates>(
                        builder: (context, state) {
                          return Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              value: cubit.isChecked,
                              onChanged: (_) {
                                cubit.rememberCheckBox();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.r),
                              ),
                              splashRadius: 10.r,
                              side: BorderSide(
                                width: 1.w,
                                color: ColorManager.borderColor,
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: FittedBox(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "agree".tr,
                                  style: GoogleFonts.redHatDisplay(
                                    fontSize: 14.sp,
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "terms".tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      cubit.launchInBrowser(
                                        Uri.parse(
                                          "https://naqaa.app/app/public/terms-and-conditions",
                                        ),
                                      );
                                    },
                                  style: GoogleFonts.redHatDisplay(
                                    fontSize: 14.sp,
                                    color: ColorManager.mainColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "and".tr,
                                  style: GoogleFonts.redHatDisplay(
                                    fontSize: 14.sp,
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextSpan(
                                  text: "policy".tr,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      cubit.launchInBrowser(
                                        Uri.parse(
                                          "https://naqaa.app/app/public/privacy-policy",
                                        ),
                                      );
                                    },
                                  style: GoogleFonts.redHatDisplay(
                                    fontSize: 14.sp,
                                    color: ColorManager.mainColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  BlocConsumer<LoginCubit, LoginStates>(
                    listener: (context, state) {
                      if (state is LoginFailureState) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "check_online".tr);
                      } else if (state is NetworkErrorState) {
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: "check_online".tr);
                      } else if (state is LoginLoadingState) {
                        customWillPopScope(context);
                      } else if (state is LoginSuccessState) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OtpView(phone: "${cubit.phoneNumber}"),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.17.sw),
                        child: CustomElevated(
                          text: "log_in".tr,
                          press: () {
                            if (cubit.formKey.currentState!.validate()) {
                              if (cubit.isChecked == false) {
                                Fluttertoast.showToast(msg: "terms_accept".tr);
                              } else if (cubit.phoneNumber.length > 12) {
                                Fluttertoast.showToast(msg: "mobile_fields".tr);
                              } else if (cubit.phoneNumber.length < 12) {
                                Fluttertoast.showToast(msg: "mobile_fields".tr);
                              } else {
                                cubit.login();
                              }
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
                  SizedBox(height: 20.h),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     CustomText(
                  //       text: "ليس لديك حساب ؟",
                  //       color: ColorManager.black,
                  //       fontSize: 15.sp,
                  //       fontWeight: FontWeight.normal,
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         navigateTo(
                  //           page: const SignUpView(),
                  //         );
                  //       },
                  //       child: CustomText(
                  //         text: "اضافة حساب",
                  //         color: ColorManager.mainColor,
                  //         fontSize: 15.sp,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
