import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/constants/custom_text.dart';
import 'package:naqaa/constants/strings.dart';
import 'package:naqaa/pages/add_order/view.dart';
import 'package:naqaa/pages/address_type/states.dart';

import 'components/card_item.dart';
import 'cubit.dart';

class ChooseAddressType extends StatelessWidget {
  const ChooseAddressType({
    Key? key,
    required this.productID,
    required this.quantity,
    required this.basketID,
  }) : super(key: key);
  final String productID, quantity, basketID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressTypeCubit(),
      child: Builder(builder: (context) {
        final cubit = AddressTypeCubit.get(context);
        cubit.getLocation();
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            centerTitle: true,
            title: CustomText(
              text: "حدد موقع التوصيل",
              color: ColorManager.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
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
                  text: "حدد موقع التوصيل",
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
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        CardTypeItem(
                          isSelected: cubit.type == AddressType.mosque,
                          continuePress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddOrderView(
                                    productID: productID,
                                    quantity: quantity,
                                    basketId: basketID,
                                    orderAddressType: " ${cubit.mosque}",
                                    lat: "${cubit.lat}",
                                    long: "${cubit.long}",
                                  );
                                },
                              ),
                            );
                          },
                          itemPress: () {
                            cubit.mosqueType();
                          },
                          image: AssetsStrings.mosqueImage,
                          title: "التوصيل للمساجد",
                          subTitle:
                              "سوف نرسل لك صورتين في 'طلباتي' بعد التسليم",
                        ),
                        CardTypeItem(
                          isSelected: cubit.type == AddressType.home,
                          continuePress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddOrderView(
                                    productID: productID,
                                    quantity: quantity,
                                    basketId: basketID,
                                    orderAddressType: " ${cubit.home}",
                                    lat: "${cubit.lat}",
                                    long: "${cubit.long}",
                                  );
                                },
                              ),
                            );
                          },
                          itemPress: () {
                            cubit.homeType();
                          },
                          image: AssetsStrings.homeImage,
                          title: "التوصيل للمنازل",
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
      }),
    );
  }
}
