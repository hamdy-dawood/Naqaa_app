import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated_icon.dart';
import 'package:naqaa/components/custom_form_field.dart';
import 'package:naqaa/components/delete_dialog.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';
import 'package:naqaa/pages/delete_account/cubit.dart';
import 'package:naqaa/pages/delete_account/states.dart';
import 'package:naqaa/pages/edit_name/view.dart';
import 'package:naqaa/pages/languages/cubit.dart';
import 'package:naqaa/pages/login/view.dart';

import 'cubit.dart';
import 'states.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navBarCubit = NavBarCubit.get(context);
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = ProfileCubit.get(context);
        final langCubit = LanguageCubit.get(context);
        final deleteCubit = DeleteAccountCubit.get(context);
        cubit.getProfileData();

        return RefreshIndicator(
          backgroundColor: ColorManager.mainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 200));
            cubit.getProfileData();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              centerTitle: false,
              title: CustomText(
                text: "profile".tr,
                color: ColorManager.black,
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return EditNameView();
                      }),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        SvgIcon(
                          height: 18.h,
                          icon: AssetsStrings.userEditIcon,
                          color: ColorManager.mainColor,
                        ),
                        SizedBox(width: 10.w),
                        CustomText(
                          text: "edit_profile".tr,
                          color: ColorManager.mainColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<ProfileCubit, ProfileStates>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    customWillPopScope(context);
                  });
                  return const SizedBox();
                } else if (state is ProfileFailureState) {
                  Navigator.pop(context);
                  return Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(state.msg),
                  );
                } else if (state is NetworkErrorState) {
                  Navigator.pop(context);
                  return ErrorNetwork();
                }
                Navigator.pop(context);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.h),
                  child: Form(
                    key: langCubit.formKey,
                    child: Column(
                      children: [
                        Divider(
                          color: ColorManager.mainColor,
                          thickness: 0.5,
                        ),
                        SizedBox(height: 20.h),
                        Expanded(
                          child: ListView(
                            children: [
                              CustomText(
                                text: "name".tr,
                                color: ColorManager.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                controller: TextEditingController(),
                                hint: "${cubit.profileData[0].userName}",
                                validator: (value) {
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomText(
                                text: "mobile_num".tr,
                                color: ColorManager.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              CustomTextFormField(
                                readOnly: true,
                                controller: TextEditingController(),
                                hint: "${cubit.profileData[0].userPhone}",
                                validator: (value) {
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              CustomElevatedWithIcon(
                                text: "logout".tr,
                                image: AssetsStrings.logoutIcon,
                                press: () {
                                  deleteDialog(
                                    context: context,
                                    title: "logout".tr,
                                    subTitle: "logout_sub".tr,
                                    yesPress: () {
                                      CacheHelper.removeUserID();
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginView()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                  );
                                },
                                btnColor: ColorManager.mainColor,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              BlocConsumer<DeleteAccountCubit,
                                  DeleteAccountStates>(
                                listener: (context, state) {
                                  if (state is DeleteAccountFailureState) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(msg: state.msg);
                                  } else if (state is DeleteNetworkErrorState) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: "check_online".tr);
                                  } else if (state
                                      is DeleteAccountLoadingState) {
                                    customWillPopScope(context);
                                  } else if (state
                                      is DeleteAccountSuccessState) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return LoginView();
                                        },
                                      ),
                                      (route) => false,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return CustomElevatedWithIcon(
                                    text: "delete_acc".tr,
                                    image: AssetsStrings.deleteIcon,
                                    press: () {
                                      deleteDialog(
                                        context: context,
                                        title: "delete_account".tr,
                                        subTitle: "delete_account_sub".tr,
                                        yesPress: () {
                                          deleteCubit.deleteAccount();
                                        },
                                      );
                                    },
                                    textColor: ColorManager.mainColor,
                                    btnColor: ColorManager.white,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Divider(
                                color: ColorManager.mainColor,
                                thickness: 0.5,
                              ),
                              SizedBox(height: 20.h),
                              CustomText(
                                text: "support".tr,
                                color: ColorManager.black,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetsStrings.supportIcon,
                                    height: 25.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    text: "support@naqaa.app",
                                    color: ColorManager.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetsStrings.whatsappIcon,
                                    height: 25.h,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  CustomText(
                                    text: "+974 66877039",
                                    color: ColorManager.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
