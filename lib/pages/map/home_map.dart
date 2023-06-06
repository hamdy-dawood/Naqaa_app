import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:naqaa/components/custom_elevated.dart';
import 'package:naqaa/constants/color_manager.dart';
import 'package:naqaa/core/cache_helper.dart';
import 'package:naqaa/pages/add_all_basket_order/view.dart';

import 'address_model.dart';

class HomeMapView extends StatefulWidget {
  const HomeMapView({Key? key, required this.location}) : super(key: key);
  final LatLng location;

  @override
  State<HomeMapView> createState() => _HomeMapViewState();
}

class _HomeMapViewState extends State<HomeMapView> {
  late LatLng currentLocation;
  Address? currentAddress;
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  int _markerIdCounter = 0;
  Completer<GoogleMapController> _mapController = Completer();
  bool isShowLoader = false;

  void _onMapCreated(GoogleMapController controller) async {
    _mapController.complete(controller);
    MarkerId markerId = MarkerId(_markerIdVal());
    LatLng position = currentLocation;
    Marker marker = Marker(
      markerId: markerId,
      position: position,
      draggable: false,
    );
    setState(() {
      _markers[markerId] = marker;
    });

    Future.delayed(Duration(seconds: 1), () async {
      GoogleMapController controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: position,
            zoom: 17.0,
          ),
        ),
      );
    });
  }

  String _markerIdVal({bool increment = false}) {
    String val = 'marker_id_$_markerIdCounter';
    if (increment) _markerIdCounter++;
    return val;
  }

  MapType type = MapType.normal;

  @override
  void initState() {
    currentLocation = widget.location;
    getLocation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
          GoogleMap(
            //markers: Set<Marker>.of(_markers.values),
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 12.0,
            ),
            mapType: type,
            myLocationEnabled: true,
            mapToolbarEnabled: true,
            onCameraMove: (CameraPosition position) {
              setState(() {
                currentLocation =
                    LatLng(position.target.latitude, position.target.longitude);
              });
            },
            onCameraIdle: () {
              getLocation();
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
              setState(() {
                if (type == MapType.normal) {
                  type = MapType.satellite;
                } else {
                  type = MapType.normal;
                }
              });
            },
            child: Container(
              height: 37,
              width: 37,
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(3)),
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
                          addressName: currentAddress?.addressName ?? '',
                          short: '',
                          type: "home",
                          id: id,
                          lat: currentAddress?.lat,
                          long: currentAddress?.long);
                      var addressM = jsonEncode(address.toJson());
                      await CacheHelper.setAddress(addressM);
                      print("SharePref Address==>> ${addressM}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return AddAllBasketOrderView(
                              orderAddressType: "mosque",
                              lat: "${currentAddress?.lat}",
                              long: "${currentAddress?.long}",
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

  getLocation() async {
    String apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${currentLocation.latitude},${currentLocation.longitude}&key=AIzaSyDjjZzMmPfqAB8xbfhXhr2yiEaJ8n5EiDg';
    final response = await Dio().get(apiUrl);
    print("API : ${apiUrl}");
    print("StatusCode: ${response.statusCode}");
    setState(() {
      isShowLoader = true;
    });
    if (response.statusCode == 200) {
      try {
        var data;
        if (response.data is Map<String, dynamic>) {
          data = response.data;
        } else if (response.data is String) {
          data = jsonDecode(response.data);
        }
        print(data);
        var address = data['results'][0]['formatted_address'];
        print("Address: $address");

        int id = 0;
        var rng = Random();
        for (var i = 0; i < 1000; i++) {
          id = rng.nextInt(100);
        }
        currentAddress = Address(
            addressName: address,
            short: '',
            type: "home",
            id: id,
            lat: "${data['results'][0]['geometry']['location']['lat']}",
            long: "${data['results'][0]['geometry']['location']['lng']}");
        print(
            "Current Address -> ${currentAddress?.lat} | ${currentAddress?.long}");
        setState(() {
          isShowLoader = false;
        });
      } catch (e) {
        print("Error: ${e.toString()}");
      }
      isShowLoader = false;
      setState(() {});
    } else {
      throw Exception('Failed to fetch restaurant data');
    }
  }
}
