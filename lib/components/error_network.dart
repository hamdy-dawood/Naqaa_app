import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';

import 'custom_elevated.dart';

class ErrorNetwork extends StatelessWidget {
  const ErrorNetwork({Key? key, required this.press, this.reloadButton = true})
      : super(key: key);
  final VoidCallback press;
  final bool reloadButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 0.15.sh,
          child: CachedNetworkImage(
            imageUrl: UrlsStrings.networkErrorUrl,
            placeholder: (context, url) => CircularProgressIndicator(
              color: ColorManager.mainColor,
            ),
            errorWidget: (context, url, error) => Center(
              child: Image.asset("assets/icons/no_network.png"),
            ),
          ),
        ),
        CustomText(
          text: "يرجي التحقق من الانترنت",
          color: ColorManager.mainColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
        ),
        SizedBox(height: 20.h),
        reloadButton
            ? CustomElevated(
                text: "إعادة التحميل",
                press: press,
                btnColor: ColorManager.mainColor,
                borderRadius: 12.r,
                fontSize: 15.sp,
              )
            : const SizedBox(),
      ],
    );
  }
}
