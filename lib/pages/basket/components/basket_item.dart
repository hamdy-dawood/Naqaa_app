import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/delete_dialog.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/basket/cubit.dart';
import 'package:naqaa/pages/edit_basket/cubit.dart';
import 'package:naqaa/pages/edit_basket/states.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.image,
    required this.quantity,
    required this.yesPressDelete,
    required this.enTitle,
    required this.enSubTitle,
    required this.basketID,
  }) : super(key: key);

  final String title,
      enTitle,
      subTitle,
      enSubTitle,
      price,
      image,
      quantity,
      basketID;
  final VoidCallback yesPressDelete;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final controller = TextEditingController(text: quantity);
      final editCubit = EditBasketCubit.get(context);
      final basketCubit = BasketCubit.get(context);

      showAlertDialog(BuildContext context) {
        AlertDialog alert = AlertDialog(
          content: SizedBox(
            width: 1.sw,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 25.sp,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: CustomText(
                    text: "enter_quantity".tr,
                    color: ColorManager.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: TextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.redHatDisplay(
                      color: ColorManager.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: GoogleFonts.redHatDisplay(
                        color: ColorManager.darkGrey,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.borderColor,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorManager.mainColor,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Divider(
                    color: ColorManager.darkGrey,
                    thickness: 0.5,
                  ),
                ),
                BlocConsumer<EditBasketCubit, EditBasketStates>(
                  listener: (context, state) {
                    if (state is EditBasketFailureState) {
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: state.msg);
                    } else if (state is EditBasketSuccessState) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      basketCubit.getBaskets();
                    }
                  },
                  builder: (context, state) {
                    if (state is EditBasketLoadingState) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        customWillPopScope(context);
                      });
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: CustomElevated(
                        text: "add".tr,
                        press: () {
                          if (controller.text == "0" || controller.text == "") {
                            Fluttertoast.showToast(msg: "empty_quantity".tr);
                          } else {
                            editCubit.editQuantity(
                              ID: basketID,
                              Quantity: controller.text,
                            );
                          }
                        },
                        btnColor: ColorManager.mainColor,
                        fontSize: 20.sp,
                        paddingVertical: 5.h,
                        borderRadius: 10.r,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }

      return Row(
        children: [
          Container(
            height: 80.h,
            width: 80.h,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Image.network(image),
            ),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: CacheHelper.getLang() == "ar" ? title : enTitle,
                        color: ColorManager.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteDialog(
                          context: context,
                          title: "delete".tr,
                          subTitle: "delete_item_sub".tr,
                          yesPress: yesPressDelete,
                        );
                      },
                      icon: Icon(
                        Icons.delete,
                        color: ColorManager.red,
                        size: 30.sp,
                      ),
                    ),
                  ],
                ),
                CustomText(
                  text: CacheHelper.getLang() == "ar" ? subTitle : enSubTitle,
                  color: ColorManager.darkGrey,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomText(
                        text: "${price} QR",
                        color: ColorManager.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.white,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            side: BorderSide(
                              color: ColorManager.mainColor,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.w,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: FittedBox(
                                    fit: BoxFit.none,
                                    child: CustomText(
                                      text: "Qty $quantity",
                                      color: ColorManager.mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.edit,
                                  color: ColorManager.black,
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
