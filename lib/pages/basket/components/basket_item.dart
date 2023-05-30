import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/delete_dialog.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';

class BasketItem extends StatelessWidget {
  const BasketItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.image,
    required this.quantity,
    required this.yesPressDelete,
    required this.itemPress,
  }) : super(key: key);

  final String title, subTitle, price, image, quantity;
  final VoidCallback itemPress, yesPressDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: ColorManager.mainColor,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.darkGrey,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgIcon(
                  height: 22.h,
                  icon: "assets/icons/location.svg",
                  color: ColorManager.black,
                ),
                SizedBox(
                  width: 10.w,
                ),
                CustomText(
                  text: "عنوان الطلب",
                  color: ColorManager.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Container(
                  height: 80.h,
                  width: 80.h,
                  margin: EdgeInsets.only(left: 12.w),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.black12,
                    ),
                  ),
                  child: Image.network(image),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomText(
                              text: title,
                              color: ColorManager.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteDialog(
                                context: context,
                                title: "هل أنت متأكد من إزالة هذا العنصر؟",
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
                        text: subTitle,
                        color: ColorManager.darkGrey,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CustomText(
                              text: price,
                              color: ColorManager.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: CustomElevated(
                              text: "Qty $quantity",
                              press: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: CustomText(
                                                text: "أدخل الكمية",
                                                color: ColorManager.black,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50.w),
                                              child: TextField(
                                                // controller: addProductCubit
                                                //     .quantityController,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                style:
                                                    GoogleFonts.redHatDisplay(
                                                  color: ColorManager.black,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                decoration: InputDecoration(
                                                  hintText: "0",
                                                  hintStyle:
                                                      GoogleFonts.redHatDisplay(
                                                    color:
                                                        ColorManager.darkGrey,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: ColorManager
                                                          .borderColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: ColorManager
                                                          .mainColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.h),
                                              child: Divider(
                                                color: ColorManager.darkGrey,
                                                thickness: 0.5,
                                              ),
                                            ),
                                            // BlocConsumer<AddProductBasketCubit,
                                            //     AddProductBasketStates>(
                                            //   listener: (context, state) {
                                            //     if (state
                                            //     is AddProductBasketFailureState) {
                                            //       Navigator.pop(context);
                                            //       Navigator.pop(context);
                                            //       showMessage(message: state.msg);
                                            //     } else if (state
                                            //     is AddProductBasketSuccessState) {
                                            //       // showMessage(message: "success");
                                            //       navigateTo(
                                            //           page: const NavBarView(),
                                            //           withHistory: false);
                                            //     }
                                            //   },
                                            //   builder: (context, state) {
                                            //     if (state
                                            //     is AddProductBasketLoadingState) {
                                            //       WidgetsBinding.instance
                                            //           .addPostFrameCallback((_) {
                                            //         customWillPopScope(context);
                                            //       });
                                            //       return const SizedBox();
                                            //     }
                                            //     return Padding(
                                            //       padding: EdgeInsets.symmetric(
                                            //           horizontal: 40.w),
                                            //       child: CustomElevated(
                                            //         text: "إضافة",
                                            //         press: () {
                                            //           addProductCubit.addProduct(
                                            //             productID: productID,
                                            //           );
                                            //         },
                                            //         btnColor:
                                            //         ColorManager.mainColor,
                                            //         fontSize: 20.sp,
                                            //         paddingVertical: 5.h,
                                            //         borderRadius: 10.r,
                                            //       ),
                                            //     );
                                            //   },
                                            // ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              btnColor: ColorManager.white,
                              textColor: ColorManager.mainColor,
                              fontSize: 15.sp,
                              paddingHorizontal: 10.w,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
