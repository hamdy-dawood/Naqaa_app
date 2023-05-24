import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/core/snack_and_navigate.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';
import 'package:naqaa/pages/login/states.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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
                  navigateTo(page: const NavBarView(), withHistory: false);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomText(
                    text: "تخطي",
                    color: ColorManager.mainColor,
                    fontSize: 20.sp,
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
                      "assets/icons/logo.svg",
                      height: 120.h,
                    ),
                  ),
                  CustomText(
                    text: "تسجيل الدخول",
                    color: ColorManager.mainColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomText(
                    text: "ادخل رقم هاتفك للإستمرار",
                    color: ColorManager.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  SizedBox(
                    height: 30.h,
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
                      child: InternationalPhoneNumberInput(
                        initialValue: PhoneNumber(isoCode: "QA"),
                        onInputChanged: cubit.onInputChanged,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "من فضلك ادخل رقم الهاتف !";
                          }
                          return null;
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.DIALOG,
                        ),
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        selectorTextStyle: TextStyle(color: ColorManager.black),
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        inputDecoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(right: 10.w, bottom: 8.w),
                          border: InputBorder.none,
                          hintText: "ادخل رقم هاتفك",
                          hintStyle: GoogleFonts.redHatDisplay(
                            color: ColorManager.borderColor,
                            fontSize: 16.sp,
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
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "اوافق علي",
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 15.sp,
                                color: ColorManager.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " الشروط والأحكام",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchInBrowser(
                                    Uri.parse(
                                      "https://naqaa.app/app/public/terms-and-conditions",
                                    ),
                                  );
                                },
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 15.sp,
                                color: ColorManager.mainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: " و ",
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 15.sp,
                                color: ColorManager.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "السياسية",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _launchInBrowser(
                                    Uri.parse(
                                      "https://naqaa.app/app/public/privacy-policy",
                                    ),
                                  );
                                },
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 15.sp,
                                color: ColorManager.mainColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                        showMessage(
                            message: "يرجي التأكد من الإيميل وكلمة السر");
                      } else if (state is NetworkErrorState) {
                        showMessage(message: "يرجي التحقق من الانترنت");
                      } else if (state is LoginLoadingState) {
                        customWillPopScope();
                      } else if (state is LoginSuccessState) {
                        navigateTo(
                            page: const NavBarView(), withHistory: false);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.17.sw),
                        child: CustomElevated(
                          text: "تسجيل الدخول",
                          press: cubit.login,
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
            ),
          ),
        );
      }),
    );
  }
}
