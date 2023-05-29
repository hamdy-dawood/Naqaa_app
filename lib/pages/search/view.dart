import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.mainColor,
        elevation: 0.0,
        title: CustomText(
          text: "بحث",
          color: ColorManager.white,
          fontSize: 22.sp,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
