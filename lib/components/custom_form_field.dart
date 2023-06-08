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
    this.suffixIcon,
    this.obscureText = false,
    this.isLastInput = false,
    this.readOnly = false,
  });

  final String hint;
  final TextInputType? keyboardType;
  final AutovalidateMode autoValidate;
  final TextEditingController? controller;
  final FormFieldValidator validator;
  final IconButton? suffixIcon;
  final bool obscureText, isLastInput, readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      autovalidateMode: autoValidate,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      textInputAction:
          isLastInput ? TextInputAction.done : TextInputAction.next,
      style: GoogleFonts.redHatDisplay(
        color: ColorManager.black,
        fontSize: 18.sp,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(12.h),
        hintText: hint,
        hintStyle: GoogleFonts.redHatDisplay(
          color: ColorManager.darkGrey,
          fontSize: 18.sp,
          fontWeight: FontWeight.normal,
        ),
        suffixIcon: suffixIcon,
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
