import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/add_all_basket_order/view.dart';
import 'package:naqaa/pages/map/address_model.dart';

import 'cubit.dart';
import 'states.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({Key? key, required this.location}) : super(key: key);
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    final cubit = HomeMapCubit.get(context);
    cubit.currentLocation = location;
    cubit.getLocation();

    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          BlocBuilder<HomeMapCubit, HomeMapStates>(
            builder: (context, state) {
              if (state is HomeMapLoadingState) {
                return CircularProgressIndicator();
              } else if (state is HomeMapFailureState) {
                return Padding(
                  padding: EdgeInsets.all(20.h),
                  child: Text("failed"),
                );
              }
              return GoogleMap(
                onMapCreated: cubit.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: cubit.currentLocation,
                  zoom: 12.0,
                ),
                mapType: cubit.type,
                myLocationEnabled: true,
                mapToolbarEnabled: true,
                onCameraMove: (CameraPosition position) {
                  cubit.currentLocation = LatLng(
                      position.target.latitude, position.target.longitude);
                  MarkerId markerId = MarkerId(cubit.markerIdVal());
                  Marker marker = Marker(
                    markerId: markerId,
                    position: cubit.currentLocation,
                    draggable: false,
                  );
                  cubit.markers[markerId] = marker;
                },
                onCameraIdle: () {
                  cubit.getLocation();
                },
              );
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: 50,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              cubit.tapMap();
            },
            child: Container(
              height: 37,
              width: 37,
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Icon(
                Icons.satellite_alt,
                size: 20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 140,
                  child: CustomElevated(
                    text: "next".tr,
                    press: () async {
                      int id = 0;
                      var rng = Random();
                      for (var i = 0; i < 1000; i++) {
                        id = rng.nextInt(100);
                      }
                      var address = Address(
                        addressName: cubit.currentAddress?.addressName ?? '',
                        short: '',
                        type: "home",
                        id: id,
                        lat: cubit.currentAddress?.lat,
                        long: cubit.currentAddress?.long,
                      );
                      var addressM = jsonEncode(address.toJson());
                      await CacheHelper.setAddress(addressM);
                      print("SharePref Address==>> ${addressM}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddAllBasketOrderView(
                              orderAddressType: "home",
                              lat: "${cubit.currentAddress?.lat}",
                              long: "${cubit.currentAddress?.long}",
                            );
                          },
                        ),
                      );
                    },
                    btnColor: ColorManager.mainColor,
                    fontSize: 18.sp,
                    borderRadius: 8.r,
                    paddingVertical: 5.w,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
