import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqaa/constants/color_manager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.autoValidate = AutovalidateMode.onUserInteraction,
    this.controller,
    required this.validator,
  });

  final String hint;

  final TextInputType? keyboardType;
  final AutovalidateMode autoValidate;
  final TextEditingController? controller;
  final FormFieldValidator validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: autoValidate,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.redHatDisplay(
        color: ColorManager.black,
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12.h),
        hintText: hint,
        hintStyle: GoogleFonts.redHatDisplay(
          color: ColorManager.grey,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.borderColor,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.mainColor,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.red,
            ),
            borderRadius: BorderRadius.circular(10.r)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorManager.red,
            ),
            borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
