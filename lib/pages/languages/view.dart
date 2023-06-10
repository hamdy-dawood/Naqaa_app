import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/core/navigate.dart';
import 'package:naqaa/pages/languages/components/language_item.dart';
import 'package:naqaa/pages/login/view.dart';

import 'cubit.dart';
import 'states.dart';

class LanguageView extends StatelessWidget {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = LanguageCubit.get(context);
      return Scaffold(
        backgroundColor: ColorManager.white,
        body: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
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
                  text: "اختر اللغة/Choose Language",
                  color: ColorManager.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlocBuilder<LanguageCubit, LanguageStates>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        LanguageItem(
                          itemPress: () {
                            cubit.arabicType();

                            Future.delayed(
                              Duration(milliseconds: 100),
                              () {
                                navigateTo(
                                    page: LoginView(), withHistory: false);
                                Get.updateLocale(const Locale('ar'));
                                CacheHelper.saveIfNotFirstTime();
                                CacheHelper.saveLang("ar");
                              },
                            );
                          },
                          title: "عربي",
                          image: AssetsStrings.logoArabicImage,
                          isSelected: cubit.type == LanguageType.arabic,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        LanguageItem(
                          itemPress: () {
                            cubit.englishType();
                            Future.delayed(
                              Duration(milliseconds: 100),
                              () {
                                navigateTo(
                                    page: LoginView(), withHistory: false);
                                Get.updateLocale(const Locale('en'));
                                CacheHelper.saveIfNotFirstTime();
                                CacheHelper.saveLang("en");
                              },
                            );
                          },
                          title: "English",
                          image: AssetsStrings.logoEnglishImage,
                          isSelected: cubit.type == LanguageType.english,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
