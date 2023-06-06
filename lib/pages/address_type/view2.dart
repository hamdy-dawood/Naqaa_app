import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqaa/components/will_pop_scope.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/add_all_basket_order/view.dart';
import 'package:naqaa/pages/address_type/states.dart';
import 'package:naqaa/pages/map/home_map.dart';

import 'components/card_item.dart';
import 'cubit.dart';

class ChooseAddressType2 extends StatelessWidget {
  const ChooseAddressType2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = AddressTypeCubit.get(context);
      cubit.getLocation();
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          centerTitle: true,
          title: CustomText(
            text: "delivery_location".tr,
            color: ColorManager.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 22.sp,
              color: ColorManager.white,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: ColorManager.mainColor,
              thickness: 0.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
              child: CustomText(
                text: "delivery_location".tr,
                color: ColorManager.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: BlocBuilder<AddressTypeCubit, AddressTypeStates>(
                builder: (context, state) {
                  cubit.mosque = "mosque";
                  cubit.home = "home";
                  return ListView(
                    children: [
                      CardTypeItem(
                        isSelected: cubit.type == AddressType.mosque,
                        continuePress: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            customWillPopScope(context);
                          });
                          Future.delayed(
                            Duration(seconds: 1),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddAllBasketOrderView(
                                      orderAddressType: " ${cubit.home}",
                                      lat: "${cubit.lat}",
                                      long: "${cubit.long}",
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        itemPress: () {
                          cubit.mosqueType();
                        },
                        image: AssetsStrings.mosqueImage,
                        title: "delivery_mosque".tr,
                        subTitle: "delivery_mosque_sub".tr,
                      ),
                      CardTypeItem(
                        isSelected: cubit.type == AddressType.home,
                        continuePress: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            customWillPopScope(context);
                          });
                          Future.delayed(
                            Duration(seconds: 1),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return HomeMapView(
                                      location: LatLng(
                                        double.parse("${cubit.lat}"),
                                        double.parse("${cubit.long}"),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        itemPress: () {
                          cubit.homeType();
                        },
                        image: AssetsStrings.homeImage,
                        title: "delivery_home".tr,
                        haveSub: false,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
