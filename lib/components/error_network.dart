import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';

class ErrorNetwork extends StatelessWidget {
  const ErrorNetwork({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: ColorManager.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.20.sh,
            child: CachedNetworkImage(
              imageUrl: UrlsStrings.networkErrorUrl,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: ColorManager.mainColor,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Image.asset(AssetsStrings.noNetworkImage),
              ),
            ),
          ),
          CustomText(
            text: "check_online".tr,
            color: ColorManager.mainColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.normal,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
