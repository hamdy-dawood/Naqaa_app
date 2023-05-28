import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/add_product_to_basket/cubit.dart';
import 'package:naqaa/pages/add_product_to_basket/states.dart';
import 'package:naqaa/pages/bottom_nav_bar/cubit.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.image,
    required this.productID,
  }) : super(key: key);

  final String title, subTitle, price, image, productID;

  @override
  Widget build(BuildContext context) {
    String token = CacheHelper.getToken();

    return Builder(
      builder: (context) {
        final addProductCubit = AddProductBasketCubit.get(context);

        return Container(
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
          child: Row(
            children: [
              Container(
                height: 80.h,
                width: 80.h,
                margin: EdgeInsets.only(left: 12.w),
                padding: EdgeInsets.all(5.w),
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
                    CustomText(
                      text: title,
                      color: ColorManager.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
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
                          child: CustomText(
                            text: price,
                            color: ColorManager.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CustomElevated(
                          text: "إضافة",
                          btnColor: ColorManager.mainColor,
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
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'\d')),
                                            ],
                                            controller: addProductCubit
                                                .quantityController,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.redHatDisplay(
                                              color: ColorManager.black,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: "0",
                                              hintStyle:
                                                  GoogleFonts.redHatDisplay(
                                                color: ColorManager.darkGrey,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color:
                                                      ColorManager.borderColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: ColorManager.mainColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
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
                                        BlocConsumer<AddProductBasketCubit,
                                            AddProductBasketStates>(
                                          listener: (context, state) {
                                            if (state
                                                is AddProductBasketFailureState) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            } else if (state
                                                is AddProductBasketSuccessState) {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              context
                                                  .read<NavBarCubit>()
                                                  .navigateToIndex(3);
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state
                                                is AddProductBasketLoadingState) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                customWillPopScope(context);
                                              });
                                              return const SizedBox();
                                            }
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40.w),
                                              child: CustomElevated(
                                                text: "إضافة",
                                                press: () {
                                                  if (addProductCubit
                                                              .quantityController
                                                              .text ==
                                                          "0" ||
                                                      addProductCubit
                                                              .quantityController
                                                              .text ==
                                                          "") {
                                                    Navigator.pop(context);
                                                  } else if (token.isEmpty) {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<NavBarCubit>()
                                                        .navigateToIndex(4);
                                                  } else {
                                                    addProductCubit.addProduct(
                                                      productID: productID,
                                                    );
                                                  }
                                                },
                                                btnColor:
                                                    ColorManager.mainColor,
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
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
