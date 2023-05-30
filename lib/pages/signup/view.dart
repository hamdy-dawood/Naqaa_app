import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/custom_form_field.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/input_validator.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/snack_and_navigate.dart';
import 'package:naqaa/pages/bottom_nav_bar/view.dart';
import 'package:naqaa/pages/signup/states.dart';

import 'cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Builder(
        builder: (context) {
          final cubit = SignUpCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            body: SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: cubit.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: SvgPicture.asset(
                          AssetsStrings.logoIcon,
                          height: 120.h,
                        ),
                      ),
                      CustomText(
                        text: "إنشاء حساب جديد",
                        color: ColorManager.mainColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.userNameController,
                        keyboardType: TextInputType.text,
                        hint: "اسم المستخدم",
                        validator: userNameValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      CustomTextFormField(
                        controller: cubit.controllers.emailController,
                        keyboardType: TextInputType.emailAddress,
                        hint: 'البريد الالكتروني',
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      Container(
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
                            hintText: "ادخل رقم هاتفك",
                            hintStyle: GoogleFonts.redHatDisplay(
                              color: ColorManager.borderColor,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 0.02.sh,
                      ),
                      BlocBuilder<SignUpCubit, SignUpStates>(
                        builder: (context, state) {
                          return CustomTextFormField(
                            controller: cubit.controllers.passwordController,
                            hint: 'كلمة المرور',
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.passwordVisibility();
                              },
                              icon: Icon(
                                cubit.securePass
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              color: ColorManager.borderColor,
                            ),
                            obscureText: cubit.securePass,
                            isLastInput: true,
                            validator: regPasswordValidator,
                          );
                        },
                      ),
                      SizedBox(
                        height: 0.04.sh,
                      ),
                      BlocConsumer<SignUpCubit, SignUpStates>(
                        listener: (context, state) {
                          if (state is SignUpFailureState) {
                            Navigator.pop(context);
                            showMessage(
                                message: state.msg, height: 60.h, maxLines: 10);
                            // showMessage(message: "من فضلك تأكد من البيانات ..");
                          } else if (state is NetworkErrorState) {
                            Navigator.pop(context);
                            showMessage(message: "يرجي التحقق من الانترنت..");
                          } else if (state is SignUpLoadingState) {
                            customWillPopScope(context);
                          } else if (state is SignUpSuccessState) {
                            navigateTo(
                                page: const NavBarView(), withHistory: false);
                          }
                        },
                        builder: (context, state) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.17.sw),
                            child: CustomElevated(
                              text: "إنشاء حساب",
                              press: cubit.signUp,
                              btnColor: ColorManager.mainColor,
                              fontSize: 18.sp,
                              borderRadius: 8.r,
                              paddingVertical: 5.w,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "لديك حساب يالفعل ؟",
                            color: ColorManager.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              text: "تسجيل الدخول",
                              color: ColorManager.mainColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
