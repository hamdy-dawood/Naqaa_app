import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/custom_form_field.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';

import 'cubit.dart';
import 'states.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditNameCubit(),
      child: Builder(
        builder: (context) {
          final cubit = EditNameCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 1.0,
              centerTitle: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 22.sp,
                  color: ColorManager.black,
                ),
              ),
              title: CustomText(
                text: "edit_profile".tr,
                color: ColorManager.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            body: Form(
              key: cubit.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.h),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
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
                      controller: cubit.nameController,
                      hint: "name".tr,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "من فضلك ادخل الاسم !";
                        } else {
                          return null;
                        }
                      },
                      isLastInput: true,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BlocConsumer<EditNameCubit, EditNameStates>(
                      listener: (context, state) {
                        if (state is EditNameFailureState) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: state.msg);
                        } else if (state is NetworkErrorState) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "check_online".tr);
                        } else if (state is EditNameLoadingState) {
                          customWillPopScope(context);
                        } else if (state is EditNameSuccessState) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          NavBarCubit.get(context).navigateToNavBarView(0);
                        }
                      },
                      builder: (context, state) {
                        return CustomElevated(
                          text: "edit".tr,
                          press: () {
                            cubit.editName();
                          },
                          textColor: ColorManager.white,
                          btnColor: ColorManager.mainColor,
                          paddingVertical: 5.h,
                          fontSize: 20.sp,
                          borderRadius: 12.r,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
