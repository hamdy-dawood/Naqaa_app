// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:naqaa/components/error_network.dart';
// import 'package:naqaa/components/svg_icons.dart';
// import 'package:naqaa/components/will_pop_scope.dart';
// import 'package:naqaa/constants/color_manager.dart';
// import 'package:naqaa/constants/custom_text.dart';
// import 'package:naqaa/constants/strings.dart';
// import 'package:naqaa/core/snack_and_navigate.dart';
// import 'package:naqaa/pages/location/view.dart';
//
// import 'components/product_item.dart';
// import 'cubit.dart';
//
// class HomeView extends StatelessWidget {
//   const HomeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(builder: (context) {
//       final cubit = AllProductsCubit.get(context);
//
//       cubit.getAllProducts();
//
//       return RefreshIndicator(
//         backgroundColor: ColorManager.mainColor,
//         color: Colors.white,
//         onRefresh: () async {
//           await Future.delayed(const Duration(milliseconds: 500));
//           cubit.getAllProducts();
//         },
//         child: Scaffold(
//           backgroundColor: ColorManager.white,
//           appBar: AppBar(
//             backgroundColor: ColorManager.white,
//             elevation: 0.0,
//             leading: IconButton(
//               onPressed: () {
//                 navigateTo(page: const LocationView());
//               },
//               icon: SvgIcon(
//                 height: 22.h,
//                 icon: AssetsStrings.locationIcon,
//                 color: ColorManager.black,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () {},
//                 icon: SvgIcon(
//                   height: 22.h,
//                   icon: AssetsStrings.notificationIcon,
//                   color: ColorManager.black,
//                 ),
//               ),
//             ],
//           ),
//           body: BlocBuilder<AllProductsCubit, AllProductsStates>(
//             builder: (context, state) {
//               if (state is AllProductsLoadingState) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   customWillPopScope(context);
//                 });
//                 return const SizedBox();
//               } else if (state is AllProductsFailedState) {
//                 Navigator.pop(context);
//                 return Padding(
//                   padding: EdgeInsets.all(20.h),
//                   child: Text(state.msg),
//                 );
//               } else if (state is NetworkErrorState) {
//                 return ErrorNetwork(
//                   press: () {
//                     cubit.getAllProducts();
//                   },
//                 );
//               }
//               return ListView(
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(right: 15.h),
//                     child: CustomText(
//                       text: "اختر منتج",
//                       color: ColorManager.black,
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.h,
//                   ),
//                   SizedBox(
//                     height: 0.72.sh,
//                     child: ListView.builder(
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         final products = cubit.allProducts!.data![index];
//                         return ProductItem(
//                           productID: "${products.productId}",
//                           title: "${products.productName}",
//                           subTitle: "${products.productDescription}",
//                           price: "${products.productPrice}",
//                           image:
//                               "${UrlsStrings.baseImageUrl}${products.productImage}",
//                         );
//                         // return ProductItem(
//                         //   title: "حجم ٢٠٠مل*٢٤عبوة (كرتون)",
//                         //   subTitle: "حجم ٢٠٠مل*٢٤عبوة (كرتون)",
//                         //   price: "10 QR",
//                         //   image: "${UrlsStrings.baseImageUrl}watershrif.jpg",
//                         //   productID: "",
//                         // );
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/components/error_network.dart';
import 'package:naqaa/components/svg_icons.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/core/snack_and_navigate.dart';
import 'package:naqaa/pages/location/view.dart';

import 'components/product_item.dart';
import 'cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        final cubit = AllProductsCubit.get(context);

        cubit.getAllProducts();
        return RefreshIndicator(
          backgroundColor: ColorManager.mainColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            cubit.getAllProducts();
          },
          child: Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              leading: IconButton(
                onPressed: () {
                  navigateTo(page: const LocationView());
                },
                icon: SvgIcon(
                  height: 22.h,
                  icon: AssetsStrings.locationIcon,
                  color: ColorManager.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgIcon(
                    height: 22.h,
                    icon: AssetsStrings.notificationIcon,
                    color: ColorManager.black,
                  ),
                ),
              ],
            ),
            body: BlocBuilder<AllProductsCubit, AllProductsStates>(
              builder: (context, state) {
                if (state is AllProductsLoadingState) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    customWillPopScope(context);
                  });
                  return const SizedBox();
                } else if (state is AllProductsFailedState) {
                  Navigator.pop(context);
                  return Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(state.msg),
                  );
                } else if (state is NetworkErrorState) {
                  return ErrorNetwork(
                    press: () {
                      cubit.getAllProducts();
                    },
                  );
                }
                Navigator.pop(context);
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.h),
                      child: CustomText(
                        text: "اختر منتج",
                        color: ColorManager.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 0.72.sh,
                      child: ListView.builder(
                        itemCount: cubit.products.length,
                        itemBuilder: (context, index) {
                          final products = cubit.products[index];
                          return ProductItem(
                            productID: "${products.productId}",
                            title: "${products.productName}",
                            subTitle: "${products.productDescription}",
                            price: "${products.productPrice}",
                            image:
                                "${UrlsStrings.baseImageUrl}${products.productImage}",
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
